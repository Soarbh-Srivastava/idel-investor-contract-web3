// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "./InvestorToken.sol";
import "./InvestorNFT.sol";

/**
 * @title IdleInvestorGame
 * @dev Main game contract managing properties and rewards
 */
contract IdleInvestorGame is Ownable, ReentrancyGuard {
    InvestorToken public investorToken;
    InvestorNFT public investorNFT;
 
    enum PropertyType { BASIC, MEDIUM, PREMIUM }
    
    struct PropertyConfig {
        uint256 price;
        uint256 rewardPerSecond;
        bool active;
    }
    
    struct PlayerProperty {
        uint256 basicCount;
        uint256 mediumCount;
        uint256 premiumCount;
        uint256 lastClaimTime;
    }
    
    uint256 public constant MIN_PROPERTY_PRICE = 50 * 10**18; 
    uint256 public constant INITIAL_PLAYER_BALANCE = 100 * 10**18;
    
    mapping(PropertyType => PropertyConfig) public propertyConfigs;
    

    mapping(address => PlayerProperty) public playerProperties;
    mapping(address => bool) public hasJoined;
    
  
    event PlayerJoined(address indexed player, uint256 nftId);
    event PropertyPurchased(address indexed player, PropertyType propertyType, uint256 count);
    event RewardsClaimed(address indexed player, uint256 amount);
    
    constructor(address _tokenAddress, address _nftAddress) Ownable(msg.sender) {
        investorToken = InvestorToken(_tokenAddress);
        investorNFT = InvestorNFT(_nftAddress);
        
        // Initialize property configurations
        propertyConfigs[PropertyType.BASIC] = PropertyConfig({
            price: 50 * 10**18,   
            rewardPerSecond: 1 * 10**15, 
            active: true
        });
        
        propertyConfigs[PropertyType.MEDIUM] = PropertyConfig({
            price: 200 * 10**18,   
            rewardPerSecond: 5 * 10**15, 
            active: true
        });
        
        propertyConfigs[PropertyType.PREMIUM] = PropertyConfig({
            price: 500 * 10**18,   
            rewardPerSecond: 15 * 10**15, 
            active: true
        });
    }
    
    /**
     * @dev Join the game - get NFT and initial tokens
     */
    function joinGame() external nonReentrant {
        require(!hasJoined[msg.sender], "Already joined the game");
        
        uint256 nftId = investorNFT.mintInvestor(msg.sender);
        
        require(
            investorToken.transfer(msg.sender, INITIAL_PLAYER_BALANCE),
            "Token transfer failed"
        );
        
        playerProperties[msg.sender].lastClaimTime = block.timestamp;
        hasJoined[msg.sender] = true;
        
        emit PlayerJoined(msg.sender, nftId);
    }
    
    /**
     * @dev Purchase properties
     */
    function buyProperty(PropertyType propertyType, uint256 count) external nonReentrant {
        require(hasJoined[msg.sender], "Must join game first");
        require(count > 0, "Count must be greater than 0");
        
        PropertyConfig memory config = propertyConfigs[propertyType];
        require(config.active, "Property type not active");
        
        uint256 totalCost = config.price * count;
        
        _claimRewards(msg.sender);
        
        require(
            investorToken.transferFrom(msg.sender, address(this), totalCost),
            "Token transfer failed"
        );
        
    
        if (propertyType == PropertyType.BASIC) {
            playerProperties[msg.sender].basicCount += count;
        } else if (propertyType == PropertyType.MEDIUM) {
            playerProperties[msg.sender].mediumCount += count;
        } else {
            playerProperties[msg.sender].premiumCount += count;
        }
        
        emit PropertyPurchased(msg.sender, propertyType, count);
    }
    
  
    function claimRewards() external nonReentrant {
        require(hasJoined[msg.sender], "Must join game first");
        _claimRewards(msg.sender);
    }
    

    function _claimRewards(address player) internal {
        uint256 rewards = calculateRewards(player);
        
        if (rewards > 0) {
            playerProperties[player].lastClaimTime = block.timestamp;
            require(
                investorToken.transfer(player, rewards),
                "Reward transfer failed"
            );
            emit RewardsClaimed(player, rewards);
        }
    }
    

    function calculateRewards(address player) public view returns (uint256) {
        PlayerProperty memory props = playerProperties[player];
        
        if (!hasJoined[player]) {
            return 0;
        }
        
        uint256 timeElapsed = block.timestamp - props.lastClaimTime;
        
        uint256 basicRewards = props.basicCount * 
            propertyConfigs[PropertyType.BASIC].rewardPerSecond * timeElapsed;
        
        uint256 mediumRewards = props.mediumCount * 
            propertyConfigs[PropertyType.MEDIUM].rewardPerSecond * timeElapsed;
        
        uint256 premiumRewards = props.premiumCount * 
            propertyConfigs[PropertyType.PREMIUM].rewardPerSecond * timeElapsed;
        
        return basicRewards + mediumRewards + premiumRewards;
    }
    

    function getPlayerProperties(address player) external view returns (
        uint256 basic,
        uint256 medium,
        uint256 premium,
        uint256 pendingRewards
    ) {
        PlayerProperty memory props = playerProperties[player];
        return (
            props.basicCount,
            props.mediumCount,
            props.premiumCount,
            calculateRewards(player)
        );
    }

    function updatePropertyConfig(
        PropertyType propertyType,
        uint256 price,
        uint256 rewardPerSecond,
        bool active
    ) external onlyOwner {
        require(price >= MIN_PROPERTY_PRICE, "Price below minimum");
        propertyConfigs[propertyType] = PropertyConfig(price, rewardPerSecond, active);
    }
   
    function withdrawTokens(uint256 amount) external onlyOwner {
        require(investorToken.transfer(owner(), amount), "Withdrawal failed");
    }
}
