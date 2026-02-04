-- Main.hs
module Main where

import Types
import Eval

-- This makes a an Int type
-- If x = Atom i = y then x = y in every evaluation
-- Mind that even numbers are true, odds are false
p, q, r :: Proposition Int
p = Atom 1
q = Atom 2
r = Atom 3

-- Find better way to do this
listProps :: [ (String, Proposition Int) ]
listProps = [ ("p", p), ("q", q), ("r", r) ]

main :: IO()
main = do
  putStrLn "These are the assigned values of the propositions"
  mapM_ (\(name, prop) -> putStrLn $ name ++ ": " ++ show (eval v prop)) listProps

  print $ eval v (p :-> p) -- True since P -> P for all P
  print $ eval v p -- Returns the value of p
  print $ eval v $ p :-> q -- Only false if ~q and p
  print $ eval v $ Not $ Not $ p -- Double Negation returns p
  print $ eval v $ Or (Not p) p -- True or False = True

  putStrLn "\nDoes P follow from P? (Should be True):"
  print $ follows p [p]
  
  putStrLn "\nDoes P follow from (Q->P), Q?"
  print $ follows p [(q:->p),q]

  putStrLn "\nFrom P, (P->Q), (Q->R) does it follow that R (1) and (P->R) (2)?"
  print $ follows r [(p:->q), (q:->r), p] -- Transitivity
  print $ follows (p:->r) [(p:->q), (q:->r)] -- Should be true

  putStrLn "\nChecks if P contradicts with Not P"
  print $ contradicts [p, (Not p)]
