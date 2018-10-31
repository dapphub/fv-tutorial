pragma solidity ^0.4.24;

import "ds-test/test.sol";

import "./timelock.sol";
import "./token.sol";

contract Hevm {
    function warp(uint256) public;
}

contract TimeLockTest is DSTest {
    Hevm hevm;
    TimeLock timelock;
    Token gem;

    function setUp() public {
        hevm = Hevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
        hevm.warp(1 hours);

        gem = new Token();
        timelock = new TimeLock(gem);
        gem.mint(this, 5 ether);
        gem.turn(timelock);
    }

    function test_lock() public {
        assertEq(gem.balanceOf(this), 5 ether);
        // lock for one week
        timelock.lock(3 ether, 604800);
        assertEq(gem.balanceOf(this), 2 ether);
    }
    function test_lock_and_free() public {
        // lock for 0 seconds
        timelock.lock(3 ether, 0);
        assertEq(gem.balanceOf(this), 2 ether);
        timelock.free(uint48(now));
        assertEq(gem.balanceOf(this), 5 ether);
    }
    function test_interest() public {
        // lock for one week
        timelock.lock(3 ether, 604800);
        assertEq(gem.balanceOf(this), 2 ether);
        // remember the maturity date
        uint48 til = uint48(now + 604800);
        // wait two weeks
        hevm.warp(1209600);
        // unlock
        timelock.free(til);
        assertEq(gem.balanceOf(this), 5005753424656851200);
    }
}
