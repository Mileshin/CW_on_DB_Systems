var mongoose = require('mongoose');
var schemas = require('./schemas');

mongoose.Promise = global.Promise;
mongoose.connect("mongodb://localhost:27017/coursework",  { useMongoClient: true });
var db = mongoose.connection;

const rl = require('readline-sync');

var funcs = {
	'add': function(splittedIinput) {
		var schema = getSchemaByName(splittedIinput[1]);
		if(schema == null) return;
		model = fillFields(schema, null);
		console.log(model);
		model.save(function(err){
		if(err) return console.log(err);
		});
	},
	'read': function(splittedIinput) {
		var schema = getSchemaByName(splittedIinput[1]);
		if(schema == null) return;
		schema.model.find({}).exec(function(err, docs){
			if(err) return console.log(err);
			console.log(docs)
			});
		},
		'findById': function(splittedIinput) {
			var schema = getSchemaByName(splittedIinput[1]);
			if(schema == null) return;
			var id = rl.question("   _id = ");
			schema.model.findById(id, function(err, docs){
				if(err) return console.log(err);
				console.log(docs)
				});
			},
	'update': function(splittedIinput) {
		var schema = getSchemaByName(splittedIinput[1]);
		if(schema == null) return;
		var field = getUniqueField(schema);
		var opt = rl.question("1: search by unique field\n2: search by _id\n");
		if(opt==1){
			var value = rl.question("   " + field + " = ");
			var query = {};
			query[field] = value;
		} else {
				var value = rl.question("   _id = ");
			}
		var props = Object.keys(schema.schema.paths);
		var newFields = {};
		props.forEach(function(field, i, arr) {
			if( field[0] != '_'){
				if( field.match(/\./) ){
					var nested = field.split(".");
					var nestedHead = nested[0];
					var nestedField = nested[1];
					if(!newFields[nestedHead]) newFields[nestedHead] = {};
					newFields[nestedHead][nestedField] = rl.question("   " + field + " = ");
				}else{
				 var str = rl.question("   " + field + " = ");
					newFields[field] = str;
				}
			}
		});
		if(opt==1){
			schema.model.findOneAndUpdate(query, newFields, {new: true}, function(err, doc){
 				if(err) return console.log(err);
				console.log("new document\n", doc);
 		});
	} else {
		schema.model.findByIdAndUpdate(value, newFields, {new: true}, function(err, doc){
			if(err) return console.log(err);
			console.log("new document", doc);
		});

	}

	},
	'delete': function(splittedIinput) {
		var schema = getSchemaByName(splittedIinput[1]);
		if(schema == null) return;
		var field = getUniqueField(schema);
		var opt = rl.question("1: remove by unique field\n2: remove by _id\n");
		if(opt==1){
			var value = rl.question("   " + field + " = ");
			var query = {};
			query[field] = value;
			schema.model.findOne(query, function(err, doc){
 				if(err) return console.log(err);
 				doc.remove(function(err){
 					if(err) return console.log(err);
					console.log("Deleted document ", doc);
 				});
 			});
		} else {
			var id = rl.question("   _id = ");
			schema.model.findByIdAndRemove(id, function(err, doc){
    		if(err) return console.log(err);
    		console.log("Deleted document ", doc);
			});
		}

	},
	'help': function(splittedIinput) {
		for(key in funcs){
			if(key!='quit' && key!='help')
			console.log(key + ' <schema_name>');
			else {
				console.log(key);
			}
		}
	},
	'quit': function(){
		process.exit(1);
	}
}

db.on('error', console.error.bind(console, 'connection error:'));

db.once('open', function() {
function run(){
	input = rl.question();
	var splittedIinput = input.split(/\s+/, 2);
	var func = getFuncByName(splittedIinput[0]);
	if(func != null)
		func(splittedIinput);
}

run();
setTimeout(function(){
console.log('enter the command:');
	process.exit(0);
}, 1000);
});

function fillFields(schema, model) {
	if( model == null ) model = new schema.model;
	schema.schema.eachPath((field) => {
		if( field[0] != '_' ){
			if( field.match(/\./) ){
				var nested = field.split(".");
				var nestedHead = nested[0];
				var nestedField = nested[1];
				model[nestedHead][nestedField] = rl.question("   " + field + " = ");
			}else model[field] = rl.question("   " + field + " = ");
		}
	});
	return model;
}

function getUniqueField(schema) {
	var tree = schema.schema.tree;
	for (var property in tree) {
		if ( tree.hasOwnProperty(property) ) {
			var field = tree[property];
			if ( (field.hasOwnProperty('index')
				 && field.index.hasOwnProperty('unique')
				 && field.index.unique)
				 || (field.hasOwnProperty('unique') && field.unique) ) {
				return property;
			}
		} }
	return null;
}

function getSchemaByName(name) {
	return getFieldByName(schemas, name, 'Unknown table: ' + name);
}

function getFuncByName(name) {
	return getFieldByName(funcs, name, 'Unknown command, see help');
}

function getFieldByName(container, name, error) {
	var f = container[name];
	if(f == null) {
		console.log(error);
	}
	return f;
}
