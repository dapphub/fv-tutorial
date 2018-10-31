pragma solidity ^0.4.24;

contract Token {
    mapping (address => uint256) public owners;
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
        owners[msg.sender] = 1;
    }
    function rely(address who) public {
        require(owners[msg.sender] == 1);
        owners[who] = 1;
    }
    function transfer(address dst, uint wad) public {
        balanceOf[msg.sender] = sub(balanceOf[msg.sender], wad);
        balanceOf[dst]        = add(balanceOf[dst], wad);
    }
    function mint(address dst, uint wad) public {
        require(owners[msg.sender] == 1);
        balanceOf[dst] = add(balanceOf[dst], wad);
    }
    function burn(address src, uint wad) public {
        require(owners[msg.sender] == 1);
        balanceOf[src] = sub(balanceOf[src], wad);
    }
}
