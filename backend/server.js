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
;
var web3 = new Web3(new Web3.providers.HttpProvider('http://127.0.0.1:7545'))
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
const LMS = contract(artifacts);
LMS.setProvider(web3.currentProvider);

MongoClient.connect(url, async(err, db) => {

    const dbe = db.db('PaymentSplitter');
    // 抓Truffle裡的所有account
    const accounts = await web3.eth.getAccounts();

    // 智能合約的創立者 defatult 都給第一個account
    web3.eth.defaultAccount = accounts[0];
  
    const lms = await LMS.deployed();

    // 處史話智能合約擁有者資訊
    lms.getParticipant(accounts[0],{from: accounts[0]}).then(async(info) =>{
        var ownerName = info[0];
        var ownerAddress = accounts[0];
        var password = "12345";
        var intialAmount = web3.utils.fromWei(await web3.eth.getBalance(ownerAddress), 'ether');
        var floatAmount = parseFloat(intialAmount);
        var personInfo = {id: 0, name: ownerName, password: password, amount:floatAmount, address: ownerAddress}

        dbe.collection("Users").findOne({"address": ownerAddress}, (err, doc) =>{
            if (! doc){
                dbe.collection("Users").insertOne(personInfo, (err, doc)=>{
                    if (err){
                        console.log("Create Owner Failed !");
                    }
                    else{
                        console.log("Create Owner Successful !");
                    }
                });
            }else{
                console.log("Owner already exists");
            }
        })
    })

    routes(app,dbe,lms,accounts, web3);

    app.listen(process.env.PORT || 8082, () => {
        console.log('listening on port '+ (process.env.PORT || 8082));
    });

});