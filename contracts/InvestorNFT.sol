// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title InvestorNFT
 * @dev NFT representing investor characters in the game
 */
contract InvestorNFT is ERC721, Ownable {
    uint256 private _tokenIdCounter;
    
    string private _baseTokenURI;
    
    mapping(address => bool) public hasClaimed;
    
    constructor(string memory baseURI) ERC721("Idle Investor", "INVESTOR") Ownable(msg.sender) {
        _baseTokenURI = baseURI;
    }
    
    /**
     * @dev Mint an investor NFT to a new player (one per address)
     */
    function mintInvestor(address player) external onlyOwner returns (uint256) {
        require(!hasClaimed[player], "Player already has an Investor NFT");
        
        uint256 tokenId = _tokenIdCounter;
        _tokenIdCounter++;
        
        _safeMint(player, tokenId);
        hasClaimed[player] = true;
        
        return tokenId;
    }
    
    /**
     * @dev Update base URI for metadata
     */
    function setBaseURI(string memory baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }
    
    /**
     * @dev Override base URI function
     */
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }
    
    /**
     * @dev Get total number of NFTs minted
     */
    function totalSupply() external view returns (uint256) {
        return _tokenIdCounter;
    }
}
