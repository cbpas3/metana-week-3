// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";

contract SimpleToken is ERC20Capped{
    address payable private _admin;

    modifier onlyAdmin {
      require(msg.sender == _admin, "SimpleToken: Not authorized to call this function.");
      _;
    }
    
    constructor() ERC20Capped(1000000*10**decimals()) ERC20("SimpleToken", "STN") {
        _admin = payable(msg.sender);
    }

    function mint() external payable {
        require(msg.value == 1*10**decimals(), "SimpleToken: Wrong amount of Eth sent.");
        _mint(msg.sender,1000*10**decimals());
    }

    function withdrawEth() external payable onlyAdmin {
        _admin.transfer(address(this).balance);
    }


}