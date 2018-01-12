var mongoose = require('mongoose');
var table = 'people';
var schema = mongoose.Schema({
  surname: {type: String, required: true},
	name: {type: String, required: true},
  middle_name: {type: String, required: true},
	date_of_birth: {type: Date, required: true},
	position: {
		name: {type: String, required: true},
		abb:  {type: String, required: true}
	},
  drivers: {
    medical_check_up: {type: Date, required: false},
    id_licence : {type: Number, required: false},
    date_of_issuance: {type: Date, required: false},
    valid_until: {type: Date, required: false},
  }
});

module.exports = {
	schema: schema,
	model: mongoose.model(table, schema)
}
