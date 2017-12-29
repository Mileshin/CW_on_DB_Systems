var mongoose = require('mongoose');
var table = 'brigades';
var schema = mongoose.Schema({
  name: {type: String, required: true},
	emblem: {type: Buffer},
});

module.exports = {
	schema: schema,
	model: mongoose.model(table, schema)
}
