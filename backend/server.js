// require('dotenv').config();
const express= require('express')
const app =express()
const bodyParser = require('body-parser')
const fs = require('fs')

app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());
app.post('/createPayment:', (req, res) => {
    payer = req.body.from
    payee = req.body.to
    transfer = req.body.amount

    fs.readFile('response.json', function(err, data) {
        if (err) {
            console.error(err)
        }
        
        var person = data.toString();
        person = JSON.parse(person);
        person[payer].amount -= transfer
        person[payee].amount += transfer

        var str = JSON.stringify(person)
        fs.writeFile("response.json", str, function(err) {
            if (err) {
                console.error(err)
            }
        })
    })
})

app.listen(process.env.PORT || 8082, () => {
    console.log('listening on port '+ (process.env.PORT || 8082));
 })