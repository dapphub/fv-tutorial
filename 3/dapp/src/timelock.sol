pragma solidity ^0.4.24;

import './token.sol';

contract TimeLock {

    Token gem;
    // per second (linear) interest rate
    // equivalent to about 10% per year    
    uint256 public rate = 3170979198;
    // debt[who][when] tracks how much is owed to who
    mapping (address => mapping (uint48 => uint256)) public debt;

    function add(uint x, uint y) internal pure returns (uint z) {
        z = x + y;
        require(z >= x);
    }
    function mul(uint x, uint y) internal pure returns (uint z) {
        z = x * y;
        require(y == 0 || z / y == x);
    }
    uint256 constant ONE = 10**18;
    function wmul(uint x, uint y) internal pure returns (uint z) {
        z = mul(x, y) / ONE;
    }

    constructor(address gem_) public {
        gem = Token(gem_);
    }

    function lock(uint256 wad, uint48 tau) public {
        uint48 til = uint48(add(now, tau));
        uint   get = add(wad, wmul(wad, mul(rate, tau)));
        debt[msg.sender][til] = add(debt[msg.sender][til], get);
        gem.burn(msg.sender, wad);
    }
    function free(uint48 era) public {
        require(era <= now);
        uint get = debt[msg.sender][era];
        debt[msg.sender][era] = 0;        
        gem.mint(msg.sender, get);
    }
}
