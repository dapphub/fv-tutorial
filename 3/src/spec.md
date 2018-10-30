# TimeLock Specification

```act
behaviour lock of TimeLock
interface lock(uint256 wad, uint48 tau)

types

    Gem       : address GemLike
    Rate      : uint256
    Debt      : uint256
    Guy_bal   : uint256
    Supply    : uint256
    Allowance : uint256
    Gem_owner : address

storage

    gem                         |-> Gem
    rate                        |-> Rate
    debt[CALLER_ID][TIME + tau] |-> Debt => Debt + (wad + #wmul(wad, Rate * tau))

storage Gem

    balances[CALLER_ID]           |-> Guy_bal => Guy_bal - wad
    supply                        |-> Supply  => Supply - wad
    approvals[CALLER_ID][ACCT_ID] |-> Tl_allowance
    owner                         |-> Gem_owner

iff

    Tl_allowance >= wad

iff in range uint256

    Guy_bal - wad

iff in range uint48

    TIME + tau

if
    Gem_owner == ACCT_ID
    VGas >= 100000
```

```act
behaviour free of TimeLock
interface free(uint48 era)

types

    Gem       : address GemLike
    Debt      : uint256
    Guy_bal   : uint256
    Supply    : uint256              
    Gem_owner : address

storage

    gem                  |-> Gem
    debt[CALLER_ID][era] |-> Debt => 0

storage Gem

    balances[CALLER_ID] |-> Guy_bal => Guy_bal + Debt
    supply              |-> Supply  => Supply + Debt
    owner               |-> Gem_owner

iff in range uint256

    Guy_bal + Debt

if
    Gem_owner == ACCT_ID
    VGas >= 100000
```
