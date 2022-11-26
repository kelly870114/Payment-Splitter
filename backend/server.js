var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/";

// require('dotenv').config();
const express= require('express')
const app =express()
const bodyParser = require('body-parser')
const fs = require('fs');
const { compileFunction } = require('vm');
const { resourceLimits } = require('worker_threads');

const routes = require('./routes')
const Web3 = require('web3');
const contract = require('truffle-contract');
const artifacts = require('./build/contracts/WeExpenses.json');
var web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:7545'))
const LMS = contract(artifacts)
LMS.setProvider(web3.currentProvider)

app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());

MongoClient.connect(url, async(err, db)=>{
  if (err) throw err;
  const dbe = db.db("PaymentSplitter");
  const accounts = await web3.eth.getAccounts();
  const lms = await LMS.deployed();

  routes(app, dbe, lms, accounts);

  app.listen(process.env.PORT || 8082, () => {
    console.log('listening on port2 '+ (process.env.PORT || 8082));
  });

});

