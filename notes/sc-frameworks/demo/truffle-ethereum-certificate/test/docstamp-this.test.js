const DocStamp = artifacts.require("DocStamp");
const { expect, assert } = require("chai");
const truffleAssert = require("truffle-assertions");

const getKeccak256Hash = (name, details) => {
  return web3.utils.soliditySha3(
    {
      t: "string",
      v: name,
    },
    {
      t: "string",
      v: details,
    }
  );
};

contract("Unit testing DocStamp", (accounts) => {
  before(async function () {
    this.deployer = accounts[0];
    this.alice = accounts[1];
    this.bob = accounts[2];
    this.docStamp = await DocStamp.deployed();
    this.testName = "Alice";
    this.testDetails = "Blockchain Development Program";
    this.expectedCertificate = getKeccak256Hash(
      this.testName,
      this.testDetails
    );
  });

  it("should have same owner as deployer", async function () {
    expect(await this.docStamp.owner()).to.equal(this.deployer);
  });

  it("should issue a certificate", async function () {
    const issueCertificateTx = await this.docStamp.issueCertificate(
      this.testName,
      this.testDetails,
      { from: this.deployer }
    );

    truffleAssert.eventEmitted(
      issueCertificateTx,
      "CertificateIssued",
      (obj) => {
        return (
          obj.record == this.expectedCertificate && obj.returnValue == true
        );
      }
    );
    expect(await this.docStamp.records(this.expectedCertificate)).to.equal(
      this.deployer
    );
  });

  it("should verify a certificate", async function () {
    expect(
      await this.docStamp.verifyCertificate(
        this.testName,
        this.testDetails,
        this.expectedCertificate
      )
    ).to.be.true;
  });

  it("should return false for wrong certificate name/details", async function(){
    expect(
      await this.docStamp.verifyCertificate(
        "Dhruv",
        this.testDetails,
        this.expectedCertificate
      )
    ).to.be.false;
  });

  it("should revert with empty name and detaild", async function() {
    await truffleAssert.reverts(
        this.docStamp.issueCertificate("", ""),
        "!certificate"
    )
})
});
