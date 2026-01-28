# Under construction

```haskell
  print $ eval example -- True since P -> P for all P
  print $ eval (Atom "P") -- False, no axiom says P is true here
  print $ eval $ (Atom "P") :-> (Atom "Q") -- Since P is False, P -> Q is true
  print $ eval $ Not $ Not $ Atom "P" -- Double Negation, False
  print $ eval $ Or (Not (Atom "P")) (Atom "Q") -- True or False = True
```

# TODO
- [ ] Write tests for:
    - [ ] Axioms that contradict
    - [x] Basic testing like the snippet shown above
- [ ] Parse through text to make the input easier
- [ ] Properly package with nix and not depend on the cabal file
- [ ] Add forall and exists quantifiers

