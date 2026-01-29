# Under construction

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

# TODO
- [ ] Write tests for:
    - [ ] Axioms that contradict
    - [x] Basic testing like the snippet shown above
- [ ] Parse through text to make the input easier
- [ ] Properly package with nix and not depend on the cabal file
- [ ] Add forall and exists quantifiers

