# Storage Layout Description

## TimeLock

```k
syntax Int ::= "#TimeLock.gem" [function]
// --------------------------------------------------
rule #TimeLock.gem => 0

syntax Int ::= "#TimeLock.rate" [function]
// --------------------------------------------------
rule #TimeLock.rate => 1

syntax Int ::= "#TimeLock.debt" "[" Int "]" "[" Int "]" [function]
// --------------------------------------------------
rule #TimeLock.debt[A][B] => #hashedLocation("Solidity", 1, A B)
```

## GemLike

```k
syntax Int ::= "#Gem.balances" "[" Int "]" [function]
// --------------------------------------------------
rule #Gem.balances[A] => #hashedLocation("Solidity", 1, A)

syntax Int ::= "#Gem.approvals" "[" Int "]" "[" Int "]" [function]
// --------------------------------------------------
rule #Gem.approvals[A][B] => #hashedLocation("Solidity", 1, A B)

syntax Int ::= "#Gem.supply" [function]
// --------------------------------------------------
rule #Gem.supply => 0

syntax Int ::= "#Gem.owner" [function]
// --------------------------------------------------
rule #Gem.owner => 1
```
