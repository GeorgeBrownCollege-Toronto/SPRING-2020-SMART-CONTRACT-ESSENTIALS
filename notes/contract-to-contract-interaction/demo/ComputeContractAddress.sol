// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract ComputeContractAddress {
    function getAddr(address addr, bytes1 nonce) public pure returns(address) {
        return address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), addr, bytes1(nonce))))));
    }
}

// Using Ethers.js and web3.js

// ethers.utils.keccak256(
//       ethers.utils.RLP.encode(
//         ["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
//       web3.utils.toHex(1)])).slice(26)


// Using only ethers.js

// ethers.utils.keccak256(
//    ethers.utils.RLP.encode(
//        ["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
//        ethers.utils.hexlify(1)])).
//        slice(26)
