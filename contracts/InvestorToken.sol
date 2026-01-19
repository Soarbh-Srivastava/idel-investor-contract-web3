// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title InvestorToken
 * @dev ERC20 token for Idle Investor Game
 * Features:
 * - Fixed max supply
 * - Burnable
 * - Pausable (emergency)
 * - Permit (gasless approvals)
 * - Game contract mint control
 */
contract InvestorToken is
    ERC20,
    ERC20Burnable,
    ERC20Pausable,
    ERC20Permit,
    Ownable
{
    uint256 public constant MAX_SUPPLY = 1_000_000 * 10 ** 18;

    /// @notice Game contract allowed to mint rewards
    address public gameContract;

    event GameContractUpdated(address indexed game);
    event RewardMinted(address indexed to, uint256 amount);

    constructor()
        ERC20("Investor Coin", "INVEST")
        ERC20Permit("Investor Coin")
        Ownable(msg.sender)
    {
        _mint(msg.sender, MAX_SUPPLY);
    }


    function setGameContract(address _gameContract) external onlyOwner {
        require(_gameContract != address(0), "Invalid address");
        gameContract = _gameContract;
        emit GameContractUpdated(_gameContract);
    }

    modifier onlyGame() {
        require(msg.sender == gameContract, "Only game contract");
        _;
    }


    function mintReward(address to, uint256 amount) external onlyGame {
        require(totalSupply() + amount <= MAX_SUPPLY, "Max supply exceeded");
        _mint(to, amount);
        emit RewardMinted(to, amount);
    }


    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }


    function _update(
        address from,
        address to,
        uint256 value
    ) internal override(ERC20, ERC20Pausable) {
        super._update(from, to, value);
    }
}
