const DocStamp = artifacts.require("DocStamp");

module.exports = function (deployer) {
  deployer.deploy(DocStamp);
};
