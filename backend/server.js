var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/";

// require('dotenv').config();
const express= require('express')
const app =express()
const bodyParser = require('body-parser')
const fs = require('fs');
const { compileFunction } = require('vm');

app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());

MongoClient.connect(url, function(err, db) {
  if (err) throw err;
  var dbo = db.db("PaymentSplitter");

  app.post('/createAccount', (req, res) =>{
      var accountName = req.body.name;
      var password = req.body.password;
      var intialAmount = 100000000000;
      var personInfo = {name: accountName, password:password, amount:intialAmount}
      dbo.collection("Users").insertOne(personInfo, ()=>{
          if (err){
              res.status(400);
              res.json({"info": "Create User Fail!"});
          };
      })
      
      res.status(200);
      res.json({"info": "Create Account!"});

  }); 
  
  app.post('/login', (req, res)=>{
      var accountName = req.body.name;
      var password = req.body.password;
      if (accountName){
        dbo.collection("Users").findOne({"name": accountName}, (err, doc) =>{
            if (doc){
                if (doc.password == password){
                    res.status(200);
                    res.json({"info": "Login Successful!"})
                }else{
                    res.status(400);
                    res.json({"info": "Wrong Password!"})
                }   
            }else{
                res.status(400);
                res.json({"info": "No user!"});
            }
        })
      }else{
        res.status(400)
        res.json({"info": "Wrong input"})
      }
  })
});

app.listen(process.env.PORT || 8082, () => {
    console.log('listening on port '+ (process.env.PORT || 8082));
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

  app.get('/showAmount/:name', (req, res) => {
    accountName = req.params.name;
    var whereStr = {"name":accountName};
    dbo.collection("Users").find(whereStr).toArray(function(err, result) {
        if (err) throw err;
        payerAmount = result[0]["amount"];
        res.status(200);
        res.json({"amount":payerAmount});
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
    dbo.collection("Users").updateOne(whereStr, updateStr, function(err, res) {
        if (err) throw err;
    });
    var whereStr = {"name":payee};
    var updateStr = {$inc: { "amount" : increase}};
    dbo.collection("Users").updateOne(whereStr, updateStr, function(err, res) {
            if (err) throw err;
        });
    res.status(200);
    res.json({"sources":"200"});
  });

});

app.listen(process.env.PORT || 8082, () => {
    console.log('listening on port2 '+ (process.env.PORT || 8082));
});