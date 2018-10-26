```
//7 days, 24 hours, 60 minutes, 60 seconds
syntax Int ::= "#week" [function]

rule #week => 7 *Int 24 *Int 60 *Int 60
```
