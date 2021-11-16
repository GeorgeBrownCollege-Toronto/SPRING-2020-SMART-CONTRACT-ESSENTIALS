//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract SimpleStorage {
    uint256 public storedData;

    function getStoredData() public view returns (uint256) {
        return storedData;
    }

    function setStoredData(uint256 x) public {
        storedData = x;
    }
}
