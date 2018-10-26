pragma solidity ^0.4.24;

contract Token {
  mapping(address => uint) public balances;
  uint public totalSupply = 0;
  
  function add(uint256 x, uint256 y) internal pure returns (uint z) {
    z = x + y;
    require(z >= x);
  }

  function sub(uint256 x, uint256 y) internal pure returns (uint z) {
    z = x - y;
    require(x >= y);
  }
  
  constructor(uint256 supply) public {
    balances[msg.sender] = supply;
    totalSupply = supply;
  }

  function transfer(address to, uint256 value) public {
    uint256 srcBal = sub(balances[msg.sender], value);
    uint256 dstBal = add(balances[to], value);
    balances[msg.sender] = srcBal;
    balances[to] = dstBal;
  }
}
