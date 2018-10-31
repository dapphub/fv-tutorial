# TimeLock Specification

```act
behaviour lock of TimeLock
interface lock(uint256 wad, uint48 tau)

types

    Gem       : address GemLike
    Rate      : uint256
    Debt      : uint256
    Guy_bal   : uint256
    Gem_owner : address

storage

    gem                         |-> Gem
    rate                        |-> Rate
    debt[CALLER_ID][TIME + tau] |-> Debt => Debt + (wad + #wmul(wad, Rate * tau))

storage Gem

    balanceOf[CALLER_ID] |-> Guy_bal => Guy_bal - wad
    owner                |-> Gem_owner

iff

    VCallDepth < 1024
    Gem_owner == ACCT_ID

iff in range uint256

    Guy_bal - wad

iff in range uint48

    TIME + tau

if
    VGas >= 100000
```

```act
behaviour free of TimeLock
interface free(uint48 era)

types

    Gem       : address GemLike
    Debt      : uint256
    Guy_bal   : uint256
    Gem_owner : address

storage

    gem                  |-> Gem
    debt[CALLER_ID][era] |-> Debt => 0

storage Gem

    balanceOf[CALLER_ID] |-> Guy_bal => Guy_bal + Debt
    owner                |-> Gem_owner

iff

    VCallDepth < 1024
    Gem_owner == ACCT_ID

iff in range uint256

    Guy_bal + Debt

if

    VGas >= 100000
```
