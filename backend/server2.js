var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/";
require('dotenv').config();
const express= require('express')
const app =express()
const bodyParser = require('body-parser')
const fs = require('fs')
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());


MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  var dbase = db.db("PaymentSplitter");
  app.post('/createparticipant', (req, res) => {
    participant = req.body.name;
    amount = req.body.amount;
//   console.log("HEllo");
    var myobj = [
        { name: participant, amount: amount}
        ];
    dbase.collection("Users").insertMany(myobj, function(err, res) {
        if (err) throw err;
        console.log("Number of documents inserted: " + res.insertedCount);
        // db.close();
    })
    res.status(200);
    res.json({"sucess":"200"});
  });
  app.post('/createparticipant', (req, res) => {
    participant = req.body.name;
    amount = req.body.amount;
//   console.log("HEllo");
    var myobj = [
        { name: participant, amount: amount}
        ];
    dbase.collection("Users").insertMany(myobj, function(err, res) {
        if (err) throw err;
        console.log("Number of documents inserted: " + res.insertedCount);
        // db.close();
    })
    res.status(200);
    res.json({"sucess":"200"});
  });
});


app.listen(process.env.PORT || 8082, () => {
    console.log('listening on port '+ (process.env.PORT || 8082));
 })