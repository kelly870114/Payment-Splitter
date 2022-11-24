var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/";

// require('dotenv').config();
const express= require('express')
const app =express()
const bodyParser = require('body-parser')
const fs = require('fs')

app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());

MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  var dbo = db.db("PaymentSplitter");
  app.post('/createParticipant', (req, res) => {
    participantName = req.body.name;
    paticipantAmount = req.body.amount;
    var myobj = [{name: participantName, amount: paticipantAmount}];
    console.log(myobj);

    dbo.collection("Users").insertMany(myobj, function(err, res) {
        if (err) throw err;
        console.log("Number of documents inserted: " + res.insertedCount);
    })
    res.status(200);
    res.json({"sources":"200"});
  });
});

app.listen(process.env.PORT || 8082, () => {
    console.log('listening on port '+ (process.env.PORT || 8082));
});
