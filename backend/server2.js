const express= require('express')
const app =express()
const bodyParser = require('body-parser')

app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());

// app.post('/createPayment', (req, res) => {
//     name_ = req.body.name
//     amount_ = req.body.amount
//     console.log(name_)

// })


var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017";


MongoClient.connect(url, function(err, db) {
    
    if (err) throw err;
    var dbo = db.db("PaymentSplitter");
    // var myobj = [
    //     { name: 'Alan', amount: 1000},
    //     { name: 'Amy', address: 2000},
    //     { name: 'Sherry', address: 3000}
    // ];

    // var myobj2;
    app.post('/createPayment', (req, res) => {
        name_ = req.body.name;
        amount_ = req.body.amount;
        console.log(name_);
        var myobj2 = [
            { name: name_, amount: amount_}
        ];
        console.log('hello');
        dbo.collection("Users").insertMany(myobj2, function(err, res) {
            if (err) throw err;
            console.log("Number of documents inserted: " + res.insertedCount);
            // db.close();
        });

        res.status(200);
        res.json({"sucess":"200"});

    })

    
});


app.listen(process.env.PORT || 8082, () => {
    console.log('listening on port '+ (process.env.PORT || 8082));
});

