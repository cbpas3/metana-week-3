// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleStaking is IERC721Receiver {
    address private immutable _owner;
    address private constant _tokenContractAddress = 0xd9145CCE52D386f254917e481eB44e9943F39138;
    address private constant _nftContractAddress = 0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8;
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
        uint256 daysDiff = (block.timestamp - stakes[_tokenId].timeStaked) / 60 / 60/ 24;
        uint256 minsDiff = (block.timestamp - stakes[_tokenId].timeStaked) / 60;
        uint256 amountOwed = STAKE_RATE * minsDiff;
        IERC20(_tokenContractAddress).transfer(msg.sender, amountOwed);
        IERC721(_nftContractAddress).safeTransferFrom( address(this),msg.sender, _tokenId);
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