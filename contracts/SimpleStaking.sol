// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleStaking is IERC721Receiver {
    // Requirement: ERC20 tokens should be transferred to the contract
    // Requirement: setApprovalForAll should be set to true in the ERC721 token contract for this contract
    
    address private immutable _owner;
    address private constant _TOKEN_CONTRACT_ADDRESS = 0xd9145CCE52D386f254917e481eB44e9943F39138;
    address private constant _NFT_CONTRACT_ADDRESS = 0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8;
    uint256 constant STAKE_RATE = 10;
    struct Stake {
        address owner;
        uint256 timeStaked;
    }

    // map staker address to stake details
    mapping (uint256 => Stake) public stakes;

    constructor() {
        _owner = msg.sender;
    }

    function stake(uint256 tokenId) external {
        stakes[tokenId] = Stake(msg.sender, block.timestamp);
        IERC721(_NFT_CONTRACT_ADDRESS).safeTransferFrom(msg.sender, address(this), tokenId);
    }

    function unstake(uint256 tokenId) external {
        require(stakes[tokenId].owner == msg.sender);
        uint256 daysDiff = (block.timestamp - stakes[tokenId].timeStaked) / 60 / 60/ 24;
        uint256 amountOwed = STAKE_RATE * daysDiff;
        require(IERC20(_TOKEN_CONTRACT_ADDRESS).transfer(msg.sender, amountOwed), "SimpleStaking: Token transfer was unsuccessful");
        IERC721(_NFT_CONTRACT_ADDRESS).safeTransferFrom( address(this),msg.sender, tokenId);
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external override returns (bytes4){
        return IERC721Receiver.onERC721Received.selector;
    }


}