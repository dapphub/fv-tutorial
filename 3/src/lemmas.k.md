```
syntax Int ::= "#one" [function]
// 10**18
rule #one => 1000000000000000000

syntax Int ::= "#wmul" "(" Int "," Int ")" [function]
rule #wmul(A, B) => (A *Int B) /Int #one
```
