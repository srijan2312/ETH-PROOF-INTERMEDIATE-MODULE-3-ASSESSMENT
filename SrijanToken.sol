// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.4.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.4.0/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.4.0/contracts/security/Pausable.sol";

contract SrijanToken is ERC20("Srijan Token", "SK"), Ownable, Pausable {

    event TokensPurchased(address indexed purchaser, uint256 amount);

    constructor() Ownable() Pausable() {}

    // Function to mint token
    function mintToken(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Token cannot be minted to the zero address");
        require(amount > 0, "The amount of minting token must be greater than zero");
        _mint(to, amount);
    }

    // Function to burn token
    function burnToken(uint256 amount) public {
        require(amount > 0, "The amount of burning token must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance to burn token");
        _burn(msg.sender, amount);
    }

    // Function to transfer token
    function transferToken(address to, uint256 amount) public whenNotPaused returns (bool) {
        require(to != address(0), "The token cannot be transferred to the zero address");
        require(amount > 0, "The amount to be transferred must be greater than zero");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance to transfer");
        _transfer(_msgSender(), to, amount);
        return true;
    }

    // Function to buy token
    function buyTokens(uint256 amount) public payable whenNotPaused {
        require(amount > 0, "Amount must be greater than zero");
        _transfer(owner(), msg.sender, amount);
    }

    // Function to pause contract
    function pause() public onlyOwner {
        _pause();
    }

    // Function to unpause contract
    function unpause() public onlyOwner {
        _unpause();
    }
}
