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
        
        lms.createExpense(title, amount, date, payeesAddress, {from: payerAddress})
            .then(() =>{
                console.log('Create Expense');
            })
            .catch((err) =>{
                console.log(err);
        })

        lms.getExpenseID({from: payerAddress})
            .then((info)=>{
                const currentExpenseID = info.words[0];
                console.log("Current ID is ", currentExpenseID);
            })
            .catch((err) =>{
                console.log(err);
            })

        res.status(200);
        res.json({"info": "Great!"});

    })

    app.post('/createPayment', async(req, res) => {
        title = req.body.title;
        payer = req.body.payer;
        payee = req.body.payee;
        amount = req.body.amount;
        increase = amount;
        decrease = -amount;

        // Update MongoDB
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

        // Update Blockchain (solidity)
        payerAddr = accounts[HASHMAP[payer]]
        payeeAddr = accounts[HASHMAP[payee]]
        amount = amount.toString(); // 先轉成string，才可以換成wei
        const intWeiAmount = web3.utils.toWei(amount, "ether");
        lms.createPayment(title, payerAddr, payeeAddr, intWeiAmount, {from: payerAddr})
        .then(()=>{
            console.log("Add to solidity!");
        })
        .catch(err=>{
            console.log(err)
        }) 

        // Update ganache
        const weiAmount = intWeiAmount.toString();
        console.log(weiAmount);
        web3.eth.sendTransaction({
            from: payerAddr,
            to: payeeAddr,
            value: weiAmount
            // value: '1000000000000000000',
            // gasPrice: Number.MAX_SAFE_INTEGER
            // gasPrice: 200000000
        })
        console.log("Add to ganache!");

        // Check ganache
        const getAmount = async () => {
            const balance = web3.utils.fromWei(
                await web3.eth.getBalance(payerAddr),
                "ether"
            )
            return balance;
        }

        var initialAmount = await getAmount();
        console.log("Check from ganache:")
        console.log(initialAmount);
        
        res.status(200);
        res.json([{"sources":"200"}]);
    });


    
}

module.exports = routes