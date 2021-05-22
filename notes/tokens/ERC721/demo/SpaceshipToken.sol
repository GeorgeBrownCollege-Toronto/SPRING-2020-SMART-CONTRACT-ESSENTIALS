// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./ERC721Standard.sol";
import "./ERC721Receiver.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

/// @title SpaceshipToken
/// @author Dhruvin
/// @notice Non fungible token representing space ship
/// @dev An ERC721 based token for spaceships
contract SpaceshipToken is ERC721Standard("CryptoSpaceships", "CST"),ERC721Receiver(0x150b7a02,false),Ownable  {
    
    /// @notice struct with spaceship attributes
    struct Spaceship {
        bytes4 metadataHash; // IPFS hash
        uint8 energy;
        uint8 lasers;
        uint8 shield;
    }
    
    ///@notice list of all the spaceships minted
    Spaceship[] public spaceships;
    
    ///@notice prices of spaceship corresponding to spaceship index
    mapping(uint256 => uint256) public spaceshipPrices;
    
    ///@notice spaceships for sale
    uint[] public shipForSale;
    
    ///@notice mapping of index to the index of spaceships for sale
    mapping(uint256 => uint256) public indexes;
    
    ///@notice Inventory and pricing of the spaceship
    ///@dev Add the spaceship to the state and assingning tokenId
    ///@param _metadataHash IPFS hash of the spaceship
    ///@param _energy energy of the spaceship
    ///@param _lasers lasers of the spaceship
    ///@param _shield shield of the spaceship
    ///@param _price price of the spaceship
    function mint(bytes4 _metadataHash, uint8 _energy, uint8 _lasers, uint8 _shield, uint256 _price) public onlyOwner {
        Spaceship memory s = Spaceship({
            metadataHash:_metadataHash,
            energy: _energy,
            lasers: _lasers,
            shield:_shield
        });
        spaceships.push(s);
        uint256 _spaceshipId = spaceships.length-1;
        
        spaceshipPrices[_spaceshipId] = _price;
        shipForSale.push(_spaceshipId);
        indexes[_spaceshipId] = shipForSale.length-1;
        
        safeMint(address(this), _spaceshipId , "");
    }
    
    ///@notice Total number of ships available to buy
    ///@dev Read the length of {shipForSale}
    ///@return uint number of ships for sale
    function shipsForSaleN() public view returns(uint) {
        return shipForSale.length;
    }
    
    ///@notice Buyer can buy spaceshift for ethers
    ///@dev transfer the ownership of {_spaceshipId} to the caller
    ///@param _spaceshipId the unique id for the spaceshift to be bought
    function buySpaceship(uint _spaceshipId) public payable {
        require(msg.value >= spaceshipPrices[_spaceshipId]);
        
        safeTransferFrom(address(this), msg.sender, _spaceshipId);
        
        uint256 replacer = shipForSale[shipForSale.length - 1];
        uint256 pos = indexes[_spaceshipId];
        shipForSale[pos] = replacer;
        indexes[replacer] = pos;
        shipForSale.pop();
        
        uint refund = msg.value - spaceshipPrices[_spaceshipId];
        if (refund > 0) {
            payable(msg.sender).transfer(refund); 
        }
    }
    
    ///@notice Owner of token can withdraw ether
    ///@dev transfer all ethers' balance from this contract to owner
    function withdrawBalance() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}