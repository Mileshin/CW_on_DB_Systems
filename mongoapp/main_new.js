var mongoose = require('mongoose');
var schemas = require('./schemas');

var options = { promiseLibrary: require('bluebird') };
mongoose.Promise = require('bluebird');
mongoose.connect("mongodb://localhost:27017/coursework",  { useMongoClient: true });
var db = mongoose.connection;

const rl = require('readline-sync');

var funcs = {
	'add': function(splitted_input) {
		var schema = get_schema_by_name(splitted_input[1]);
		if(schema == null) return;
		model = fill_fields(schema, null);
		console.log(model);
		model.save((err) => print_errors(err));
	},
	'read': function(splitted_input) {
		var schema = get_schema_by_name(splitted_input[1]);
		if(schema == null) return;
		schema.model.find({}).exec(function(err, docs){
			if(err) return console.log(err);
			console.log(docs)
			});
		},
	'update': function(splitted_input) {
		var schema = get_schema_by_name(splitted_input[1]);
		var field = get_unique_field(schema);
		var value = rl.question("   " + field + " = ");
		var query = {};
		query[field] = value;
		 schema.model.findOne(query, function(err, row){
			if(err) return console.log(err);
			var model = fill_fields(schema, row);
			console.log(model);
			row.save((err) => print_errors(err));
		});
	},
	'delete': function(splitted_input) {
		var schema = get_schema_by_name(splitted_input[1]);
		if(schema == null) return;
		var field = get_unique_field(schema);
		var value = rl.question("   " + field + " = ");
		var query = {};
		query[field] = value;
		 schema.model.findOne(query, function(err, row){
			if(err) return console.log(err);
			row.remove((err) => print_errors(err));
		});
	},
	'help': function(splitted_input) {
		for(key in funcs){
			if(key=='add' || key=='read' || key=='update' || key=='delete')
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

var err_code = 0;
db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', function() {

function run(){
	input = rl.question();
	var splitted_input = input.split(/\s+/, 2);
	var func = get_func_by_name(splitted_input[0]);
	if(func != null)
		func(splitted_input);
}

run();
console.log('enter the command:');
setTimeout(function(){

	process.exit(0);
}, 1000);



});

function fill_fields(schema, model) {
	if( model == null ) model = new schema.model;
	schema.schema.eachPath((field) => {
		if( field[0] != '_' ){
			if( field.match(/\./) ){
				var nested = field.split(".");
				var nested_head = nested[0];
				var nested_field = nested[1];
				model[nested_head][nested_field] = rl.question("   " + field + " = ");
			}else model[field] = rl.question("   " + field + " = ");
		}
	});
	return model;
}

function fill_fields2(schema) {
  moddd ={};
	schema.schema.eachPath((field) => {
		if( field[0] != '_' ){
			var per;
			if( field.match(/\./) ){
			/*	per = rl.question("   " + field + " = ");
				if (per !== null && per !== ''){
				var nested = field.split(".");
				var nested_head = nested[0];
				var nested_field = nested[1];
					console.log(per);
					moddd[nested_head][nested_field] = per;
				}*/

			}else {
				per = rl.question("   " + field + " = ");
				if (per !== null && per !== ''){
					console.log(per);
					moddd[field] = per;
				}

			}
		}
	});
	return moddd;
}



function get_unique_field(schema) {
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

function check_fields_num(fields, num) {
	if(fields.length < num) {
		console.log("Too few fields");
		return true;
	} else
		return false;
}

function get_schema_by_name(name) {
	return get_field_by_name(schemas, name, 'Unknown table: ' + name);
}

function get_func_by_name(name) {
	return get_field_by_name(funcs, name, 'Unknown command, see help');
}

function get_field_by_name(container, name, error) {
	var f = container[name];
	if(f == null) {
		console.log(error);
	}
	return f;
}

function print_errors(err) {
	if( err != null ) console.log(err.message);
	db.close();
}
