require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: process.env.RINKEBY_URL="https://rinkeby.infura.io/v3/730ffec0386f48ce9c164f3111769aaf",
    accounts: [process.env.PRIVATE_KEY= "838b150089f9e868e394d60e75f8f285b04c58a5667b4678796bafeaa69dcf93"],
      
    }
  }
};
