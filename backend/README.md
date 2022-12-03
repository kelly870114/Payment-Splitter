# Group Expenses : WeExpenses

WeExpense is a solidity smart contract to manage group expenses on Ethereum Blockchain.
It allows participants to record expenses in order to settle debts in a trusless environment.
Only registered participant can add other participant.

Feel free to reuse this smart contract to create a group expense for experimental use only.

See more : [Manage Group Expenses on Ethereum Blockchain with Solidity](https://medium.com/@adrien.arcuri.pro/manage-group-expenses-on-ethereum-blockchain-with-solidity-e0026f2720f3)

## Getting started

We use [Truffle](https://github.com/trufflesuite/truffle) as development environment framework and [Ganache CLI](https://github.com/trufflesuite/ganache-cli) as Ethereum RP client.
Clone this Github project and make sur you have the following installed :

```
npm install -g ganache-cli
npm install -g truffle
```

Then, run :

```
npm install
```

## Test

```
ganache-cli
truffle test
```

## Test it in Remix IDE

The contract is testable in [Remix IDE](https://remix.ethereum.org/).
You can use this test set :

1. Alice create the contract and register herself as a participant. Use the 1st Remix Account (0xca35b7d915458ef540ade6068dfe2f44e8fa733c) and add "Alice" in the input argument, then push Create:

![Create contract](https://user-images.githubusercontent.com/10615593/37865314-6d0e9b18-2f7b-11e8-9aa8-892c8748c4db.png)

Create :
```javascript
"Alice"
```

2. Create the other participants with Alice's account (only registered participant can add new participants) :

![CreateParticipant](https://user-images.githubusercontent.com/10615593/37865334-8fdd883e-2f7b-11e8-81b7-7977659d2b23.png)

createParticipant :
```javascript
"Bob", "0x14723a09acff6d2a60dcdf7aa4aff308fddc160c"
"Cris", "0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db"
"Denis", "0x583031d1113ad414f02576bd6afabfb302140225"
```

3. Create several expenses : Alice pays 100 [Finney](https://medium.com/@tjayrush/what-the-f-is-a-finney-8e727f29e77f) for the food for all. Bob pays for restaurant 50 Finney only for Alice and him. Cris pays 300 Finney of travel cost for Alice, Bob and Denis but not for him. Do not forget to change sender's account when you submit the transaction :

![CreateExpense](https://user-images.githubusercontent.com/10615593/37865362-c01714e8-2f7b-11e8-9e73-baec4fe889e4.png)


createExpense :
```javascript
// From Alice's account
"Food", 100000000000000000, 1519135382, ["0xca35b7d915458ef540ade6068dfe2f44e8fa733c","0x14723a09acff6d2a60dcdf7aa4aff308fddc160c", "0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db", "0x583031d1113ad414f02576bd6afabfb302140225"]

// From Bob's account
"Restaurant", 50000000000000000, 1519135382, ["0x14723a09acff6d2a60dcdf7aa4aff308fddc160c", "0xca35b7d915458ef540ade6068dfe2f44e8fa733c"]

// From Cris's account
"Travel", 300000000000000000, 1519135382, ["0xca35b7d915458ef540ade6068dfe2f44e8fa733c", "0x14723a09acff6d2a60dcdf7aa4aff308fddc160c", "0x583031d1113ad414f02576bd6afabfb302140225"]
```

4. Each participant involved in an expense give its agreement for the expense.

![SetAgreement](https://user-images.githubusercontent.com/10615593/37865363-c1eb4f64-2f7b-11e8-93cf-842d04813885.png)


setAgreement :
```javascript
// From Alice's account, Bob's account, Cris's account, Denis's account for expense "Food" (4 times)
0, true
```
5. Get the balance of each participant. You should have the following : Alice: 75000000000000000, Bob: -25000000000000000, Cris: -25000000000000000, Denis: -25000000000000000.

![GetBalance](https://user-images.githubusercontent.com/10615593/37865396-3349cb90-2f7c-11e8-9505-b3e75bf3eb18.png)


GetBalance : 
```javascript
"0xca35b7d915458ef540ade6068dfe2f44e8fa733c"

"0x14723a09acff6d2a60dcdf7aa4aff308fddc160c"

"0x4b0897b0513fdc7c541b6d9d7e929c4e5364d2db"

"0x583031d1113ad414f02576bd6afabfb302140225"

```
6. Make a payment from Bob to Alice of 25 Finney. When you use this function, do not forget to send ether corresponding to the amount of the payment, otherwise the payment fails. 

![CreatePayment](https://user-images.githubusercontent.com/10615593/37865399-3733e8d0-2f7c-11e8-994b-7e4fcb1bdf75.png)
![Set25Finney](https://user-images.githubusercontent.com/10615593/37865401-3984d856-2f7c-11e8-9641-7cbc07d49bd6.png)


CreatePayment :
```javascript
// From Bob's account
"TxBobToAlice","0xca35b7d915458ef540ade6068dfe2f44e8fa733c"
```

7. Observe Alice's withdrawal. It should be equal to 25000000000000000.

![GetWithdrawal](https://user-images.githubusercontent.com/10615593/37865397-359f0ac2-2f7c-11e8-9d7d-d2ba9edaf268.png)


GetWithdrawal or withdrawals :
```javascript
"0xca35b7d915458ef540ade6068dfe2f44e8fa733c"
```

8. Withdraw from Alice's account. Just push "withdraw. :

![Withdraw](https://user-images.githubusercontent.com/10615593/37865394-31c4d332-2f7c-11e8-9a23-1e1434647c83.png)

Observe Alice's withdrawal again (step 7). It should be equal to 0.

The Alice's account should be increased by 25 Finney (0.025 Ether).

Observe all the balance (step 5). You should have : Alice: 50000000000000000, Bob: 0, Cris: -25000000000000000, Denis: -25000000000000000.

9. Cancel the agreement of Cris on the first expense.

GetWithdrawal or withdrawals :
setAgreement
```javascript
// From Cris' account
0, false
```

Observe all the balances (step 5).

You should have : Alice: 41666666666666667, Bob: -8333333333333333 Cris: 0, Denis: -33333333333333333.


## License

Realesed under MIT License [here](https://github.com/adrienarcuri/weexpenses-sol/blob/master/LICENSE).
