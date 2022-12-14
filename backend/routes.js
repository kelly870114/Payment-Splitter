const HASHMAP = {
    "amy": 0,
    "alan": 1,
    "sherry": 2,
    "byron": 3,
    "lance": 4,
    "ginny": 5
} 


function routes(app, dbe, lms, accounts, web3){
    let db = dbe.collection("Users")


    app.post('/createAccount', async (req, res) =>{
        var accountName = req.body.name;
        var password = req.body.password;
        var accountid = HASHMAP[accountName];
        var address = (accounts[accountid]);
        const getAmount = async () => {
            const balance = web3.utils.fromWei(
                await web3.eth.getBalance(address),
                "ether"
            );
            return balance;
        }

        var initialAmount = await getAmount();
        var floatAmount = parseFloat(initialAmount);
        var personInfo = {id: accountid, name: accountName, password:password, amount:floatAmount, address: address};
        lms.createParticipant(accountName, address, {from: accounts[0]})
            .then(()=>{
                db.insertOne(personInfo, (err, doc)=>{
                    if (err){
                        res.status(400);
                        res.json([{"info": "Create User Fail!"}]);
                    };
                });
            })
            .catch(err=>{
                console.log(err)
                
            })
        res.status(200);
        res.json([{"info": "Create Account!"}]);
  
    }); 
    
    app.post('/login', (req, res)=>{
        var accountName = req.body.name;
        var password = req.body.password;
        if (accountName){
          dbo.findOne({"name": accountName}, (err, doc) =>{
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

  
    app.get('/showAmount/:name', (req, res) => {
      accountName = req.params.name;
      var whereStr = {"name":accountName};
      db.findOne(whereStr, (err, result) => {
          if (err) throw err;
          payerAmount = result["amount"];
        //   console.log(typeof(parseInt(payerAmount, 10)));
          res.status(200);
          res.json([{"amount":payerAmount}]);
      });
    });
    app.get('/showParticipant/:id', (req, res) => {
        id = req.params.id;
        address  = accounts[id];
        lms.getParticipant(address)
            .then((name, balance, address)=>{
                
                console.log([{"Name":name, "Address":address}]);
                res.status(200);
                res.json([{"Name":name, "Balance": balance, "Address": address}]);
            })
            .catch(err=>{
                console.log(err)
               
            })
        
      });
  
    app.post('/createExpense',(req, res) =>{
        var title = req.body.title;
        var amount = req.body.amount;
        var date = req.body.date;
        var payer = req.body.payer;
        var payees = req.body.payees;

        var payerAddress = accounts[HASHMAP[payer]];
        var payeesAddress = [];

        payees.forEach((p) =>{
            payeesAddress.push(accounts[HASHMAP[p]]);
        });

        var strAmount = amount.toString();
        var weiAmount = web3.utils.toWei(strAmount, 'ether');
        
        lms.createExpense(title, weiAmount, date, payeesAddress, {from: payerAddress})
            .then(() =>{
                console.log('Create Expense');
                lms.getExpenseID({from: payerAddress})
                    .then((info)=>{
                        console.log(info)
                        const currentExpenseID = info.words[0];
                        console.log('currentExpense ID', currentExpenseID);
                        res.status(200);
                        res.json({"info": "Create Expense Successful!", "expenseID": currentExpenseID});
                    })
                    .catch((err) =>{
                        console.log(err);
                        res.status(400);
                        res.json({"info": "Fail to create expense" });
                     })
            
            })
            .catch((err) =>{
                console.log(err);
                res.status(400);
                res.json({"info": "Fail to create expense" });
        })

        
        
        

    })

    app.post('/agree',(req, res) =>{
        var agreeName = req.body.name;
        var expenseID = req.body.expenseID;

        var agreeAddress = accounts[HASHMAP[agreeName]];

        lms.setAgreement(expenseID, true, {from: agreeAddress, gas:3000000})
            .then(() =>{
                console.log("success")
            })
            .catch((err) =>{
                console.log(err);
            })

        res.status(200);
        res.json({"info":`${agreeName} agree expense ${expenseID}`});
    })

    app.get('/getAllParticipants', (req, res) =>{

        db.find({}, {'name': true}).toArray(function(err, results) {
            var checker = accounts[0];
            var participants = [];
            results.forEach((p) =>{
                participants.push(p.name);
            });
            var checkerAddress = accounts[HASHMAP[checker]];
            var participantsAddress = [];

            participants.forEach((p) =>{
                participantsAddress.push(accounts[HASHMAP[p]]);
            });

            lms.getAllParticipants(participantsAddress, {from: checkerAddress})
            .then((info) =>{

                const balanceObject = []

                for(var i = 0; i < participants.length; i++){
                    var balance = BigInt(info[1][i]).toString()
                    balanceObject.push({'name':participants[i], 'balance':balance })
                }
                res.status(200);
                res.json({"info": "check all participants successful", "balanceInfo":balanceObject});


            })
            .catch((err) =>{
                console.log(err)
                res.status(400);
                res.json({"info":"Fail to view all participants"});
            })

        });

    })

    app.post('/createPayment', async(req, res) => {
        var payer = req.body.payer;
        var payee = req.body.payee;
        var title = req.body.title;
        var amount = req.body.amount;

        var payerAddress = accounts[HASHMAP[payer]];
        var payeeAddress = accounts[HASHMAP[payee]];

        var strAmount = amount.toString();
        var weiAmount = web3.utils.toWei(strAmount, 'ether');
        weiAmount = parseInt(weiAmount);

        lms.createPayment(title, payeeAddress, {from: payerAddress, value: weiAmount, gas:3000000})
            .then(async(info) =>{
                console.log('create payment');
                
                lms.withdraw({from: payeeAddress})
                    .then(async(info)=>{
                        console.log("with draw successful");
                        // console.log(info);

                        // Update MongoDB
                        const getAmount = async (address) => {
                            const balance = web3.utils.fromWei(
                                await web3.eth.getBalance(address),
                                "ether"
                            );
                            return balance;
                        }
                        var payerNewAmount = await getAmount(payerAddress);
                        var payeeNewAmount = await getAmount(payeeAddress);

                        var whereStr = {"name":payer};
                        var updateStr = {$set: { "amount" : parseFloat(payerNewAmount)}};
                        db.updateOne(whereStr, updateStr, function(err, res) {
                            if (err) throw err;
                        });
                        var whereStr = {"name":payee};
                        var updateStr = {$set: { "amount" : parseFloat(payeeNewAmount)}};
                        db.updateOne(whereStr, updateStr, function(err, res) {
                            if (err) throw err;
                        });
                    })
                    .catch((err) => {
                        console.log(err);
                    })
            })
            .catch((err) => {
                console.log(err);
            })

        res.status(200);
        res.json({"info": "make payment"});
        
    })
    
}

module.exports = routes