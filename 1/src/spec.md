```
behaviour transfer of DemurrageToken
interface transfer(address To, uint Value)

types 

    FromBal : uint256
    ToBal   : uint256
    CallerLastTouched : uint256

storage

    #hashedLocation("Solidity", 1, CALLER_ID) |-> CallerLastTouched
    #hashedLocation("Solidity", 0, CALLER_ID) |-> FromBal => (99 * FromBal) / 100 - Value
    #hashedLocation("Solidity", 0, To)        |-> ToBal   => ToBal + Value


iff in range uint256
    
    FromBal - Value
    ToBal + Value

iff 
    
    TIME - CallerLastTouched > #week * 10

if
    VGas >= 100000
```
