### arithmetic

```k
syntax Int ::= "#one" [function]
// 10**18
rule #one => 1000000000000000000

syntax Int ::= "#wmul" "(" Int "," Int ")" [function]
rule #wmul(A, B) => (A *Int B) /Int #one
```

### hashed storage

```k
// hashed storage offsets never overflow (probabilistic assumption):
rule chop(keccakIntList(L) +Int N) => keccakIntList(L) +Int N
  requires N <=Int 100

// solidity also needs:
rule chop(keccakIntList(L)) => keccakIntList(L)
// and
rule chop(N +Int keccakIntList(L)) => keccakIntList(L) +Int N
  requires N <=Int 100
```

### miscellaneous

```k
rule WS ++ .WordStack => WS

rule #sizeWordStack ( #padToWidth ( 32 , #asByteStack ( #unsigned ( W ) ) ) , 0) => 32
  requires #rangeSInt(256, W)

rule #asWord(#padToWidth(32, #asByteStack(#unsigned(X)))) => #unsigned(X)
  requires #rangeSInt(256, X)

rule #take(N, #padToWidth(N, WS) ) => #padToWidth(N, WS)
```
