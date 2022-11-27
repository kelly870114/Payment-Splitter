const Web3 = require('web3');
const contract = require('truffle-contract');
const artifacts = require('./build/contracts/WeExpenses.json');


var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/";

require('dotenv').config();
const Web3 = require('web3');
const contract = require('truffle-contract');
const routes = require('./routes')
const express= require('express')
const app = express()
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
  // 抓Truffle裡的所有account
  const accounts = await web3.eth.getAccounts();
  web3.eth.defaultAccount = accounts[0];
  
  const lms = await LMS.deployed();
  // console.log(lms.getParticipantName);
  
  routes(app,dbe,lms,accounts);

  app.listen(process.env.PORT || 8082, () => {
    console.log('listening on port '+ (process.env.PORT || 8082));
  });

});

