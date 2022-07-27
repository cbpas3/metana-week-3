// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleStaking is IERC721Receiver {
    address private immutable _owner;
    address private constant _tokenContractAddress = 0x1c91347f2A44538ce62453BEBd9Aa907C662b4bD;
    address private constant _nftContractAddress = 0x417Bf7C9dc415FEEb693B6FE313d1186C692600F;
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

    function stake(uint256 _tokenId) external {
        stakes[_tokenId] = Stake(msg.sender, block.timestamp);
        IERC721(_nftContractAddress).safeTransferFrom(msg.sender, address(this), _tokenId);
    }

    function unstake(uint256 _tokenId) external {
        require(stakes[_tokenId].owner == msg.sender);
        uint256 daysDiff = (block.timestamp - stakes[_tokenId].timeStaked) / 60 / 60 / 24;
        uint256 amountOwed = STAKE_RATE * daysDiff;
        IERC20(_tokenContractAddress).transfer(msg.sender, amountOwed);
        IERC721(_nftContractAddress).safeTransferFrom( address(this),msg.sender, _tokenId);
    }


}