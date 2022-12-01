// Allows us to use ES6 in our migrations and tests.
contracts_directory: '/Users/wei-tingho/paymentsplitterdb/backend/contracts',
require('babel-register')({
  ignore: /node_modules\/(?!zeppelin-solidity\/test\/helpers)/
});
require('babel-polyfill');
module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    ddevelopment: {
      host: "localhost",
      port: 7545,
      network_id: "*" // match any network
    }
    
  }
}