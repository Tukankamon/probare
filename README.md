# Under construction

This program evaluates a logical statement and returns either True or False
The following are the allowed Logical operations for propositions p and q:
```
p :-> q -- p implies q
Not p -- ~p
And p q -- p && q
Or p q -- p || q
```

Each proposition type contains a variable "a" that is used to diferentiate them and later calculate their truth values

There also exists a proposition type called atom
Each "Atom" is a proposition that we hardcode a truth value two with the function:
(It is currently set for even = True, odd = False for developer convenience)
```haskell
v :: Int -> Bool
-- These two are permanent
v 0 = False
v 1 = True
v n
  | n `mod` 2 == 0 = False
  | otherwise = True
```

And later on you can use these as "Axiom n" directly or give them a name
```haskell
-- If x = Atom i = y then x = y in every evaluation
p, q, r :: Proposition Int
p = Atom 1
q = Atom 2
r = Atom 3
```

Here is an example with a bunch of logical statements
```haskell
main :: IO()
main = do
  putStrLn "These are the assigned values of the propositions"
  mapM_ (\(name, prop) -> putStrLn $ name ++ ": " ++ show (eval v prop)) listProps
  putStrLn "\n"

  print $ eval v (p :-> p) -- True since P -> P for all P
  print $ eval v p -- Returns the value of p
  print $ eval v $ p :-> q -- Only false if ~q and p
  print $ eval v $ Not $ Not $ p -- Double Negation returns p
  print $ eval v $ Or (Not p) p -- True or False = True

```

Returns the following:
```
These are the assigned values of the propositions
p: True
q: False
r: True


True
True
False
True
True
```

The follows function however returns if the proposition follows from the premises
It does not care about its value from v but because of the definition of proposition
they still need to be defined with a variable value
```haskell
-- These propositions dont care what value they are assigned by v
-- This just checks through modus ponens
putStrLn "\nDoes X follow from P? (Should be True):"
print $ follows [p] p

putStrLn "\nDoes P follow from (Q->P), Q?"
print $ follows [(q:->p),q] p
```

Will output:
```
Does P follow from P? (Should be True):
True

Does P follow from (Q->P), Q?
True
```

# TODO
- [ ] Write tests for:
    - [ ] Axioms that contradict
    - [x] Basic testing like the snippet shown above
- [ ] Parse through text to make the input easier
- [ ] Properly package with nix and not depend on the cabal file
- [ ] Add forall and exists quantifiers
- [x] Add way to check if a proposition follows from the arguments (eval doesnt do it)
- [ ] Make the eval function better so it can return p when v p is undefined
    - [ ] Make it also not dependant on a so I can remove it from the type definition. Rather assign each proposition a string like "p" in main

