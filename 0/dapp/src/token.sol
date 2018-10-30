contract Token {
  mapping(address => uint) public balanceOf;
  uint public totalSupply;
  address public owner;

  constructor(uint supply) {
    totalSupply = supply;
    owner = msg.sender;
    balanceOf[msg.sender] = supply;
  }

  function mint(uint value, address destination) public {
    require(msg.sender == owner);
    balanceOf[destination] += value;
  }
  
  function transfer(address to, uint256 value) public {
    require(balanceOf[msg.sender] >= value);
    balanceOf[msg.sender] -= value;
    balanceOf[to] += value;
  }
}
