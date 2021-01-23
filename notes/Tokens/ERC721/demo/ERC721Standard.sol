// SPDX-License-Identifier: MIT

pragma solidity ^0.7.1;

import "./IERC721.sol";

contract ERC721Standard is IERC721 {
    
    mapping(address => uint256[]) private _holderToTokens;
    
    mapping(uint256 => address) private _tokenIdToHolder;
    
    mapping(uint256 => address) private _tokenApprovals;
    
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    function balanceOf(address _owner) public override view returns (uint256) {
        require(_owner != address(0), "ERC721 : balance query for zero address");
        return _holderToTokens[_owner].length;
    }
    
    function ownerOf(uint256 _tokenId) public override view returns (address) {
        return _tokenIdToHolder[_tokenId];
    }
    
    function approve(address _operator, uint256 _tokenId) public override payable {
        address _owner = _tokenIdToHolder[_tokenId];
        require(_owner == msg.sender, "ERC721: approve caller is not owner nor approved for all");
        require(_owner != _operator, "ERC721: approval to current owner");
        _tokenApprovals[_tokenId] = _operator;
        emit Approval(_owner, _operator, _tokenId);
    }
    
    function getApproved(uint256 _tokenId) public override view returns (address) {
        return _tokenApprovals[_tokenId];    
    }
    
    function setApprovalForAll(address _operator, bool _approved) public override {
        require(_operator != msg.sender, "ERC721: approve to caller");
        _operatorApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }
    
    function isApprovedForAll(address _owner, address _operator) public override view returns (bool) {
        return _operatorApprovals[_owner][_operator];   
    }
    
    function transferFrom(address _from, address _to, uint256 _tokenId) public override payable {
        // msg.sender should be approved
        address _owner = _tokenIdToHolder[_tokenId];
        address _spender = msg.sender;
        bool _isApprovedOrOwner = (_owner  == _spender || getApproved(_tokenId) == _spender || isApprovedForAll(_owner, _spender));
        require(_isApprovedOrOwner, "ERC721: transfer caller is not owner nor approved");
        
        require(_owner == _from, "ERC721: transfer of token that is not own");
        require(_to != address(0), "ERC721: transfer to the zero address");
        
        // clear approvals from previous owner
        approve(address(0), _tokenId);
        
        // remove _from from _holderToTokens
        uint8 _len = uint8(balanceOf(_from));
        for(uint8 _i = 0 ; _i < _len ; _i++) {
            if(_holderToTokens[_from][_i] == _tokenId) {
                delete _holderToTokens[_from][_i];
            }            
        }
        
        // add _to from _holderToTokens
        _holderToTokens[_to].push(_tokenId);
        
        // emit event
        emit Transfer(_from, _to, _tokenId);
    }
    
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) public override payable {
        
    }
    
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) public override payable {
        
    }
    
}
