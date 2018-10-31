pragma solidity ^0.4.24;

contract Token {
    address public owner;
    mapping (address => uint256) public balanceOf;

    function add(uint x, uint y) internal pure returns (uint z) {
        z = x + y;
        require(z >= x);
    }
    function sub(uint x, uint y) internal pure returns (uint z) {
        z = x - y;
        require(z <= x);
    }
    constructor () public {
        owner = msg.sender;
    }
    function turn(address who) public {
        require(msg.sender == owner);
        owner = who;
    }
    function transfer(address dst, uint wad) public {
        balanceOf[msg.sender] = sub(balanceOf[msg.sender], wad);
        balanceOf[dst]        = add(balanceOf[dst], wad);
    }
    function mint(address dst, uint wad) public {
        require(msg.sender == owner);
        balanceOf[dst] = add(balanceOf[dst], wad);
    }
    function burn(address src, uint wad) public {
        require(msg.sender == owner);
        balanceOf[src] = sub(balanceOf[src], wad);
    }
}
