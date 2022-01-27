module.exports = {
  networks: {
      //download ganache-cli and type `ganache-cli` in your console to start a locally hosted blockchain
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    }
  },
  compilers: {
    solc: {
      version: "^0.8.11"
    }
  }
};
