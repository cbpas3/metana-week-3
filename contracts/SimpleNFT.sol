// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract SimpleNFT is ERC721{

    uint256 public tokenSupply = 0;
    uint256 public constant MAX_SUPPLY = 10;
    uint256 public constant PRICE = 0.001 ether;
    address private immutable _owner;

    constructor() ERC721("PoPanda", "PP"){
        _owner = msg.sender;
    }

    function mint() external payable {
        require(tokenSupply < MAX_SUPPLY, "SimpleNFT: Supply limit reached.");
        require(msg.value == PRICE, "SimpleNFT: Not enough Ether.");
        _mint(msg.sender, tokenSupply);
        tokenSupply++;
    }

    function viewBalance() external view returns (uint256){
        return balanceOf(msg.sender);
    }

    function withdraw() external {
        require(msg.sender == _owner);
        payable(msg.sender).transfer(address(this).balance);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://Qmaq72oDd6Vfj7kA8ziC4DKt5aAMjCmZKpiLXeCmRJn2ue/";
    }
    

}