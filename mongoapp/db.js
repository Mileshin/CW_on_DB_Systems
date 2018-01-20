var mongoose = require('mongoose');
var schemas = require('./schemas');
mongoose.Promise = require('bluebird');
mongoose.connect("mongodb://localhost:27017/coursework",  { useMongoClient: true });
var db = mongoose.connection;

var pl = new schemas.people.model;

pl.surname="mileshin";
pl.name="andrey";
pl.middle_name="alexandrovich";
pl.date_of_birth="1997-09-09";

pl.position = {
  name: "tttttt",
  abb:  "tr",
},
pl.drivers = {
  medical_check_up: "2009-09-10",
  id_licence : "19909",
  date_of_issuance: "2009-09-10",
  valid_until: "2009-09-10"
}

var pl2 = new schemas.people.model;

pl2.surname="mileshin";
pl2.name="andrey";
pl2.middle_name="alexandrovich";
pl2.date_of_birth="1997-09-09";

pl2.position = {
  name: "tttttt",
  abb:  "tr",
}

var bu = new schemas.buses.model;
bu.number_plate="р789рр";
bu.working_status=true;
bu.vehicle_inspection="2009-09-09";
bu.types_of_buses = {
  brand: "BMV-13",
  model: "131",
  seats: 34
}


db.on('error', console.error.bind(console, 'connection error:'));

db.once('open', function() {
	// we're connected!
	console.log('ok');
	pl.save(function(err){
    if(err) return console.log(err);
    console.log("Сохранен объект:\n",pl);
    console.log("\n\n");
//  mongoose.disconnect();
  });

  pl2.save(function(err){
    if(err) return console.log(err);
    console.log("Сохранен объект:\n",pl2);
    console.log("\n\n");
//  mongoose.disconnect();
  });

  bu.save(function(err){
    if(err) return console.log(err);
    console.log("Сохранен объект:\n",bu);
    console.log("\n\n");
//  mongoose.disconnect();
  });

  schemas.people.model.find({name: "andrey"}).exec(function(err,docs).pretty(){
  //  mongoose.disconnect();
    if(err) return console.log(err);
    console.log("Найденные объеты:\n",docs);
    console.log("\n\n");
  });





});
