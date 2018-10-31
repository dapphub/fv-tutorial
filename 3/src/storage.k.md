# Storage Layout Description

## TimeLock

```k
syntax Int ::= "#TimeLock.gem" [function]
// --------------------------------------
rule #TimeLock.gem => 0

syntax Int ::= "#TimeLock.rate" [function]
// ---------------------------------------
rule #TimeLock.rate => 1

syntax Int ::= "#TimeLock.debt" "[" Int "]" "[" Int "]" [function]
// ---------------------------------------------------------------
rule #TimeLock.debt[A][B] => #hashedLocation("Solidity", 2, A B)
```

## GemLike

```k
syntax Int ::= "#Gem.owner" [function]
// -----------------------------------
rule #Gem.owner => 0

syntax Int ::= "#Gem.balanceOf" "[" Int "]" [function]
// --------------------------------------------------
rule #Gem.balanceOf[A] =>  #hashedLocation("Solidity", 1, A)
```
