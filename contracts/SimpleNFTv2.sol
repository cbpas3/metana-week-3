// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract SimpleNFTv2 is ERC721{
    // This contract should be given allowance by the msg.sender
    // Ideally this would be hidden in the backend 

    address private constant _TOKENCONTRACTADDRESS = 0xd9145CCE52D386f254917e481eB44e9943F39138;
    
    uint256 public tokenSupply = 0;
    uint256 public constant MAX_SUPPLY = 10;
    uint256 public constant PRICE = 1 * 10^18;
    address private immutable _owner;

    constructor() ERC721("PoPanda", "PP"){
        _owner = msg.sender;
    }

    function mint() external payable {
        require(tokenSupply < MAX_SUPPLY, "SimpleNFT: Supply limit reached.");
        // require(msg.value == PRICE, "SimpleNFT: Not enough Ether.");
        tokenSupply++;
        _mint(msg.sender, tokenSupply);
        require(IERC20(_TOKENCONTRACTADDRESS).balanceOf(msg.sender) >= PRICE, "SimpleNFT: Not enough Ether.");
        require(IERC20(_TOKENCONTRACTADDRESS).transferFrom(msg.sender,address(this), PRICE),"SimpleNFT: Tranfer was unsuccessful");
    }

    function viewBalance() external view returns (uint256){
        return balanceOf(msg.sender);
    }

    function withdraw() external {
        require(msg.sender == _owner);
        payable(msg.sender).transfer(address(this).balance);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://Qmf26APXuuGWee6GYJLvkJ4ZDsASdb7DQtqrysY6jEQ5z5/";
    }
    

}