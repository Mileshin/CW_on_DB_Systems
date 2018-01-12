var mongoose = require('mongoose');
var table = 'buses';
var schema = mongoose.Schema({
  number_plate: {type: String, required: true, unique: true,},
	vehicle_inspection_date: {type: String, required: true},
  working_status: {type: Boolean, required: true},
	types_of_buses: {
		brand: {type: String, required: false},
		model:  {type: String, required: false},
    seats: {type: Number, required: true}
	},
  routes: {
    start: {type: String, required: false},
    stop: {type: String, required: false},
    list_of_station: {type: [String], required: false}
  }
});

module.exports = {
	schema: schema,
	model: mongoose.model(table, schema)
}
