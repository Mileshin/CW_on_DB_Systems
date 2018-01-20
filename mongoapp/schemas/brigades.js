var mongoose = require('mongoose');
var table = 'brigades';
var schema = mongoose.Schema({
  name: {type: String, required: true, unique: true},
	emblem: {type: Buffer, required: false},
  people: [{
    id : {type: Number, unique: true, required: true},
    surname: {type: String, required: true},
    name: {type: String, required: true},
    middle_name: {type: String, required: true},
  }]
});

module.exports = {
	schema: schema,
	model: mongoose.model(table, schema)
}
