var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/";

require('dotenv').config();
const Web3 = require('web3');
const contract = require('truffle-contract');
const routes = require('./routes')
const express= require('express')
const app =express()
const bodyParser = require('body-parser')
const artifacts = require('./build/contracts/WeExpenses.json');
// const fs = require('fs');
// const { compileFunction } = require('vm');
// const contract = require('truffle-contract');
// const artifacts = require('./build/Inbox.json');
var web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:7545'))
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
const LMS = contract(artifacts);
LMS.setProvider(web3.currentProvider)

MongoClient.connect(url, async(err, db) => {

  const dbe = db.db('PaymentSplitter');
  const accounts = await web3.eth.getAccounts();
  const lms = await LMS.deployed();

  routes(app,dbe,lms,accounts);

  app.listen(process.env.PORT || 8082, () => {
    console.log('listening on port2 '+ (process.env.PORT || 8082));
});

});

