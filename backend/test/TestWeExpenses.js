const WeExpenses = artifacts.require("WeExpenses");
const assert = require("assert");
const _deploy_contracts = require("../migrations/2_deploy_contracts");

<<<<<<< HEAD
contract('WeExpenses', )
=======
contract("WeExpenses", (account)=>{
    const BUYER = accounts[1];

    it("should allower a user to buy a ticket", async() =>{
        const instance = await WeExpenses.deployed;
        
        await instance.createParticipant("AMY", 0xfDa4a967973f0fCd01A030B487C204D4C8D40aa2)
    })

})
>>>>>>> backend
