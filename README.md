# Payment Splitter

Due to the widespread use of cryptocurrencies, many people are building NFTs or DeFi projects together, and they will need a safe and reliable way to split the crypto profits. Hence, for this project, we aim to develop a crypto asset splitter application for users to keep track of their shared crypto transactions. We are using Swift for our frontend, Node.js for our backend, and Solidity for smart contracts, along with other tools such as Truffle, Ganache-CLI, MongoDB.
![316604976_557487779543503_944918957921620849_n](https://user-images.githubusercontent.com/39258998/205422924-42152c6b-0e8d-4034-aa68-2ea960f650cd.png)


## Installation

We use Truffle as development environment framework and Ganache CLI as Ethereum RP client. Clone this Github project and make sure you have the following installed :

```bash
npm install -g ganache-cli
npm install -g truffle
```
Then, run :
```bash
npm install
```

We also use MongoDB as our backup storage.
```bash
```

## Getting Started
1. Open MongoDB Compass and run it
```bash
cd /usr/local/mongodb/bin
./mongod --dbpath ~/data/db
```
2. Go to the backend folder
```
cd backend
```
3. Run Ganache and open Ganache GUI
```bash
ganache-cli
```
<img width="570" alt="截圖 2022-12-02 下午9 52 13" src="https://user-images.githubusercontent.com/31930515/205426732-32a872fd-04ca-4af7-b678-f7047aafad35.png">


4. Migrate and Deploy smart contract
```bash
truffle migrate --reset 
```
<img width="578" alt="截圖 2022-12-02 下午9 56 04" src="https://user-images.githubusercontent.com/31930515/205426791-52d25451-4cde-45a5-9313-01eef33d10bd.png">


5. Run backend file
```bash
npm run start
```

6. Run the application by using Xcode

## Collaboration
<img width="1033" alt="螢幕快照 2022-12-02 下午20 33 18 下午" src="https://user-images.githubusercontent.com/39258998/205422983-811583ed-951b-454c-9277-131c2a331292.png">
n
