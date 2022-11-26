// const shortid = require('short-id')
// const IPFS = require("ipfs-api")
// const ipfs = new IPFS({host: 'ipfs.infura.io', port: 5001, protocol: 'https'})

// const express= require('express')
// const app =express()
// const bodyParser = require('body-parser')
// const fs = require('fs');
// const { compileFunction } = require('vm');
// const contract = require('truffle-contract');
// const artifacts = require('./build/Inbox.json');

// app.use(bodyParser.urlencoded({extended:false}));
// app.use(bodyParser.json());

function routes(app, dbe, lms, accounts){
    let db = dbe.collection("Users")
    app.post('/createAccount', (req, res) =>{
        var accountName = req.body.name;
        var password = req.body.password;
        var intialAmount = 100000000000;
        var personInfo = {name: accountName, password:password, amount:intialAmount}
        db.insertOne(personInfo, (err, doc)=>{
            if (err){
                res.status(400);
                res.json([{"info": "Create User Fail!"}]);
            };
        })
        
        res.status(200);
        res.json([{"info": "Create Account!"}]);
  
    }); 
    
    app.post('/login', (req, res)=>{
        var accountName = req.body.name;
        var password = req.body.password;
        if (accountName){
          db.findOne({"name": accountName}, (err, doc) =>{
              if (doc){
                  if (doc.password == password){
                      res.status(200);
                      res.json([{"info": "Login Successful!"}])
                  }else{
                      res.status(400);
                      res.json([{"info": "Wrong Password!"}])
                  }   
              }else{
                  res.status(400);
                  res.json([{"info": "No user!"}]);
              }
          })
        }else{
          res.status(400)
          res.json([{"info": "Wrong input"}])
        }
    })
  
    app.post('/createParticipant', (req, res) => {
      participantName = req.body.name;
      paticipantAmount = req.body.amount;
      var myobj = [{name: participantName, amount: paticipantAmount}];
      console.log(myobj);
  
      db.insertMany(myobj, function(err, res) {
          if (err) throw err;
          console.log("Number of documents inserted: " + res.insertedCount);
      })
      res.status(200);
      res.json([{"sources":"200"}]);
    });
  
    app.get('/showAmount/:name', (req, res) => {
      accountName = req.params.name;
      var whereStr = {"name":accountName};
      db.findOne(whereStr, (err, result) => {
          if (err) throw err;
          payerAmount = result["amount"];
          res.status(200);
          res.json([{"amount":payerAmount}]);
      });
    });
  
    app.post('/createPayment', (req, res) => {
      payer = req.body.payer;
      payee = req.body.payee;
      amount = req.body.amount;
      increase = amount;
      decrease = -amount;
      console.log(payer);
      var whereStr = {"name":payer};
      var updateStr = {$inc: { "amount" : decrease}};
      db.updateOne(whereStr, updateStr, function(err, res) {
          if (err) throw err;
      });
      var whereStr = {"name":payee};
      var updateStr = {$inc: { "amount" : increase}};
      db.updateOne(whereStr, updateStr, function(err, res) {
              if (err) throw err;
          });
      res.status(200);
      res.json([{"sources":"200"}]);
    });


    
}

module.exports = routes