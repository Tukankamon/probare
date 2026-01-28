-- Main.hs
module Main where

import Types
import Eval

example :: Proposition
example = ((Atom "x") :-> (Atom "x")) -- Tautology

main :: IO()
main = do
  print $ eval example -- True since P -> P for all P
  print $ eval (Atom "P") -- False, no axiom says P is true here
  print $ eval $ (Atom "P") :-> (Atom "Q") -- Since P is False, P -> Q is true
  print $ eval $ Not $ Not $ Atom "P" -- Double Negation, False
  print $ eval $ Or (Not (Atom "P")) (Atom "P") -- True or False = True
  print $ eval $ Not $ Equal Eset ZZ -- Equal is not defined yet so always gives true

