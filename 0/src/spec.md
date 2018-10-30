
```act
behaviour transfer of Token
interface transfer(address to, uint256 value)

types
   SrcBal : uint256
   DstBal : uint256

storage

    #hashedLocation("Solidity", 0, CALLER_ID) |-> SrcBal => SrcBal - value
    #hashedLocation("Solidity", 0, to)        |-> DstBal => DstBal + value

iff
    SrcBal >= value

if
    VGas >= 100000

```
