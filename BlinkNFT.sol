// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract BlinkIt is ERC721, ERC721Enumerable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    //uint public totalSupply = 10;
    uint public maxsupply = 10;

    mapping(address => uint) public mintedWallet;

    constructor() ERC721("BlinkIt", "BLN") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://api.mynft.com/tokens/";
    }

    function Mint(address to) public{
        require(totalSupply() < maxsupply, "sorry cant mint more NFT's");
        _tokenIdCounter.increment();
        require(totalSupply() <= maxsupply, "sorry cant mint more NFT's");
        require(mintedWallet[msg.sender] < 3, "Sorry! user cant mint more than 3 times");
        uint256 tokenId = _tokenIdCounter.current();
    
         mintedWallet[msg.sender]++;
        _safeMint(to, tokenId);
       
    }
    
    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}

