-- Main.hs
module Main where

import Types
import IntAxioms
--import Logic -- Not needed

example :: Proposition
example = ((Atom "x") :-> (Atom "x")) -- Tautology

-- Final output of if a prop is true
eval :: Proposition -> Bool
eval (p :-> q) = (not $ eval p) || eval q -- Only false if p -> ~q
eval (Not p) = not $ eval p
eval (And p q) = (eval p) && (eval q)
eval (Or p q) = (eval p) || (eval q)
eval p = False -- Not necesarily false, just doesnt follow from the axioms

main :: IO()
main = do
  print $ eval example -- True since P -> P for all P
  print $ eval (Atom "P") -- False, no axiom says P is true here
  print $ eval $ (Atom "P") :-> (Atom "Q") -- Since P is False, P -> Q is true
  print $ eval $ Not $ Not $ Atom "P" -- Double Negation, False
  print $ eval $ Or (Not (Atom "P")) (Atom "Q") -- True or False = True

