const Web3 = require('web3');
const contract = require('truffle-contract');
const artifacts = require('./build/contracts/WeExpenses.json');


var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/";

// require('dotenv').config();
const express= require('express')
const app =express()
const bodyParser = require('body-parser')
const fs = require('fs');
const routes = require('./routes')
const { compileFunction } = require('vm');

app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());

MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  var dbo = db.db("PaymentSplitter");

  routes(app,dbo);
  app.listen(process.env.PORT || 8082, () => {
    console.log('listening on port2 '+ (process.env.PORT || 8082));
  });
});

