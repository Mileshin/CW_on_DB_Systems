var mongoose = require('mongoose');
var table = 'people';
var schema = mongoose.Schema({
  id : {type: Number, unique: true, required: true},
  surname: {type: String, required: true},
	name: {type: String, required: true},
  middle_name: {type: String, required: true},
	date_of_birth: {type: String, required: true},
	position: {
		name: {type: String, required: true},
		abb:  {type: String, required: true}
	},
  drivers: {
    medical_check_up: {type: String, required: false},
    id_licence : {type: Number, required: false},
    date_of_issuance: {type: String, required: false},
    valid_until: {type: String, required: false},
  }
});

module.exports = {
	schema: schema,
	model: mongoose.model(table, schema)
}
