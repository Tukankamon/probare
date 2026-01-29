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
```haskell
v :: Int -> Bool
-- These two are permanent
v 0 = False
v 1 = True

v 2 = False
v 3 = True
v _ = False -- Catch all, could make this a Nothing
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


# TODO
- [ ] Write tests for:
    - [ ] Axioms that contradict
    - [x] Basic testing like the snippet shown above
- [ ] Parse through text to make the input easier
- [ ] Properly package with nix and not depend on the cabal file
- [ ] Add forall and exists quantifiers
- [ ] Add way to check if a proposition follows from the arguments (eval doesnt do it)

