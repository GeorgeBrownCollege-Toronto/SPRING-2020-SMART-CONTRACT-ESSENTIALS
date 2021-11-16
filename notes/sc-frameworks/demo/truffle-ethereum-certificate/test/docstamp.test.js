const DocStamp = artifacts.require("DocStamp");
const { expect, assert } = require("chai");
const truffleAssert = require("truffle-assertions");

const getKeccak256Hash = (name,details) => {
    return web3.utils.soliditySha3({
        t: "string",
        v: name
    }, {
        t: "string",
        v: details
    });
}

contract('DocStamp', (accounts) => {

    let instance;
    let account;
    let otherAccount;
    const name = "Dhruvin"
    const details = "Blockchain Development Program"

    before(async () => {
        account = accounts[0];
        otherAccount = accounts[1];
        instance = await DocStamp.deployed();
    })

    it("should have same owner as account", async () => {
        expect(await instance.owner()).to.be.equal(account);
    })

    it("should have same owner as account", async () => {
        const owner = await instance.owner();
        assert.equal(owner, account);
    })

    it("should issue a certificate", async () => {
        const expectedCertificate = getKeccak256Hash(name,details)

        const issueCertificateTx = await instance.issueCertificate(name, details);

        truffleAssert.eventEmitted(issueCertificateTx, "CertificateIssued", (obj) => {
            return (
                obj.record == expectedCertificate &&
                obj.returnValue == true
            )
        });

        const expectedIssuingAuthority = account;
        const issuingAuthority = await instance.records(expectedCertificate);
        assert.equal(issuingAuthority, expectedIssuingAuthority);
    })

    it("should revert with empty name and detaild", async () => {
        await truffleAssert.reverts(
            instance.issueCertificate("", ""),
            "!certificate"
        )
    })

    it("should verify a certificate", async () => {
        const expectedCertificate = getKeccak256Hash(name,details)
        const verified = await instance.verifyCertificate(name,details,expectedCertificate);
        expect(verified).to.be.true
    })

    it("should return false for wrong certificate name/details", async () => {
        const expectedCertificate = getKeccak256Hash(name,details);
        const verified = await instance.verifyCertificate("Dhruv",details,expectedCertificate);
        expect(verified).to.be.false
    })

    it("should return false when called from other account", async () => {
        const expectedCertificate = getKeccak256Hash(name,details);
        const verified = await instance.verifyCertificate(name,details,expectedCertificate,{from:otherAccount});
        expect(verified).to.be.false
    })
})