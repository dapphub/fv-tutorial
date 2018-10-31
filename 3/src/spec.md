# TimeLock Specification

```act
behaviour lock of TimeLock
interface lock(uint256 wad, uint48 tau)

types

    Gem     : address GemLike
    Rate    : uint256
    Debt    : uint256
    Guy_bal : uint256
    Can     : uint256

storage

    gem                         |-> Gem
    rate                        |-> Rate
    debt[CALLER_ID][TIME + tau] |-> Debt => Debt + (wad + #wmul(wad, Rate * tau))

storage Gem

    balanceOf[CALLER_ID] |-> Guy_bal => Guy_bal - wad
    owners[ACCT_ID]      |-> Can

iff

    VCallDepth < 1024
    Can == 1

iff in range uint256

    Rate * tau
    wad * (Rate * tau)
    wad + wad * (Rate * tau)
    Debt + wad + wad * (Rate * tau)
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

    Gem     : address GemLike
    Debt    : uint256
    Guy_bal : uint256
    Can     : uint256

storage

    gem                  |-> Gem
    debt[CALLER_ID][era] |-> Debt => 0

storage Gem

    balanceOf[CALLER_ID] |-> Guy_bal => Guy_bal + Debt
    owners[ACCT_ID]      |-> Can

iff

    VCallDepth < 1024
    era <= TIME
    Can == 1

iff in range uint256

    Guy_bal + Debt

if

    VGas >= 100000
```
