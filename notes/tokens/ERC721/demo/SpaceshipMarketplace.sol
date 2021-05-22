// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./SpaceshipToken.sol";

///@title Spaceship Marketplace
///@author Dhruvin
///@notice A platform to buy-sell spaceship
///@dev Escrow contract
contract SpaceshipMarketplace  {
    
    ///@notice custom Sale struct with attributes 
    struct Listing {
        uint256 spaceshipId;
        uint256 price;
        address owner;
    }
    
    ///@notice instance of a SpaceshipToken
    SpaceshipToken public token; // address
    
    ///@notice list of all sales
    Listing[] public listings;
    
    ///@notice saleId assigned to each sale
    mapping(uint256 => uint256) public spaceshipListings;
    
    ///@notice log the first of the spaceship
    event NewSale(uint256 indexed spaceshipId, uint indexed price, uint indexed listingId);
    
    ///@notice log resale of the spaceship
    event ShipSold(uint256 indexed spaceshipId, uint price, address indexed previousOwner, address indexed newOwner);
    
    ///@notice Initializing the marketplace
    ///@dev assigning the SpaceshipToken address to the {token} instance
    ///@param _token address of the SpaceshipToken
    constructor(address _token) {
        token = SpaceshipToken(_token);
    }
    
    ///@notice The buyer can buy spaceshipToken
    ///@dev transfer ownership of {_spaceshipId} to caller for ether 
    ///@param _listingId address of the SpaceshipToken
    function buy(uint _listingId) external payable {
        Listing memory l = listings[_listingId];
        
        require(l.owner != msg.sender);
        
        require(msg.value >= l.price);
        
        uint256 refund = msg.value - l.price;
        if(refund > 0) {
            payable(msg.sender).transfer(refund);
        }
        
        payable(l.owner).transfer(l.price);
        
        
        token.safeTransferFrom(address(this),msg.sender,l.spaceshipId);
        
        // TODO make changes to contract state
        delete spaceshipListings[l.spaceshipId];
        
        Listing memory replacer = listings[listings.length - 1];
        listings[l.spaceshipId] = replacer;
        listings.pop();
        
        emit ShipSold(l.spaceshipId, l.price,l.owner,msg.sender);
    }
    
    ///@notice The owner of spaceship can listing
    ///@dev transfer ownership of {_spaceshipId} to caller for ether 
    ///@param _spaceshipId the serial number if the spaceship
    ///@param _price The listing price of the spaceship
    function forSale(uint256 _spaceshipId, uint256 _price) external payable {
        // buyer will have to externally call token.approve(address(this),_spaceshipId)
        token.safeTransferFrom(msg.sender, address(this),_spaceshipId);
        
        Listing memory l = Listing({
            spaceshipId:_spaceshipId,
            price:_price,
            owner:msg.sender
        });
        
        listings.push(l);
        uint256 _listingId = listings.length;
        spaceshipListings[_spaceshipId] = _listingId;
        
        emit NewSale(_spaceshipId, _price, _listingId);
    }
    
    ///@notice Remove the listing
    ///@dev transfer ownership back to listing creator 
    ///@param _spaceshipId The serail number of the spaceship
    function withdraw(uint256 _spaceshipId) external {
        require(msg.sender == listings[spaceshipListings[_spaceshipId]].owner);
        delete spaceshipListings[_spaceshipId];
        Listing memory replacer = listings[listings.length - 1];
        listings[_spaceshipId] = replacer;
        listings.pop();
        token.safeTransferFrom(address(this),msg.sender, _spaceshipId);
    }
    
    ///@notice Get total number of listings
    ///@dev read the length of the {listings} 
    ///@return uint256 The lenght of the {listings}
    function nListing() public view returns(uint256) {
        return listings.length;
    }
}