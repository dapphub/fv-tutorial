pragma solidity ^0.4.24;

contract DemurrageToken {
  //Demurrage is the cost associated with owning or holding currency over a given period.
  //Users token balance decreases by 1% at transfer if it has been held for more than
  //10 weeks.
  //
  //THIS CODE HAS BEEN GIVEN INTENTIONAL ERROR(S)
  //Can you find them?

  mapping(address => uint) public balanceOf;
  mapping(address => uint) public lastTouched;
 
  constructor(uint supply) {
    balanceOf[msg.sender] = supply;
  }

  //Overflow safe arithmetic
  function add(uint256 x, uint256 y) internal pure returns (uint z) {
    z = x + y;
    require(z >= x);
  }
  
  function sub(uint256 x, uint256 y) internal pure returns (uint z) {
    z = x - y;
    require(x >= y);
  }
  
  function mul(uint256 x, uint256 y) internal pure returns (uint256 z) {
    if (x == 0) {
      return 0;
    }
    z = x * y;
    require(z / y == x);
  }

  function demurrage(address hodler) internal {
    //Subtracts 1% from users balance if there has
    //been more than 10 weeks since last time
    if (sub(now, lastTouched[hodler]) > 10 weeks) {
      balanceOf[hodler] = mul(99, balanceOf[hodler]) / 100;
      lastTouched[hodler] = now;
    }
  }
                                               
  function transfer(address to, uint256 value) public {
    demurrage(msg.sender);
    balanceOf[msg.sender] = sub(balanceOf[msg.sender], value);
    balanceOf[to] = add(balanceOf[to], value);
  }
  


  //"That means that under our current system it makes sense to cut down
  //trees and put the money in the bank; the money in the bank will grow
  //faster than trees. It makes sense to "save" money by building poorly
  //insulated houses because the discounted cost of the extra energy over
  //the lifetime of the house is cheaper than insulating. We can, however,
  //design a monetary system that does the opposite; it actually creates
  //long-term thinking through what is called a `demurrage charge.`"
  //
  //Bernard Lietaer
}
