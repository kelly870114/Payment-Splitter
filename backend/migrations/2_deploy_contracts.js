var WeExpenses = artifacts.require("./WeExpenses.sol");

module.exports = function(deployer) {
    deployer.deploy(WeExpenses, "amy");
  };
