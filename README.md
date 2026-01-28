# Under construction

```haskell
  print $ eval example -- True since P -> P for all P
  print $ eval (Atom "P") -- False, no axiom says P is true here
  print $ eval $ (Atom "P") :-> (Atom "Q") -- Since P is False, P -> Q is true
  print $ eval $ Not $ Not $ Atom "P" -- Double Negation, False
  print $ eval $ Or (Not (Atom "P")) (Atom "Q") -- True or False = True
```


