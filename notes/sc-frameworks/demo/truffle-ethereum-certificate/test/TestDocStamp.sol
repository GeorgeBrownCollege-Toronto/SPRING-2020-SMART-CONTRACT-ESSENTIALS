// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/DocStamp.sol";

contract TestDocStamp {
    function testIssueCertificateWithNewContract() public {
        DocStamp docStamp = new DocStamp();
        docStamp.issueCertificate("Alice", "Blockchain Development Program");
        bytes32 _expectedCertificate = keccak256(abi.encodePacked("Alice", "Blockchain Development Program"));
        Assert.equal(docStamp.records(_expectedCertificate),address(this),"Certificate issuer is incorrect");
        Assert.equal(docStamp.verifyCertificate("Alice", "Blockchain Development Program", _expectedCertificate),true,"Certificate verification is not as expected");
    }
}