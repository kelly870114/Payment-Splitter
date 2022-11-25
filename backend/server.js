var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://127.0.0.1:27017/";

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
});