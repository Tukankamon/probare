-- Main.hs
module Main where

import Types
import Eval
import Parser

p, q, r :: Proposition
p = Atom "p"
q = Atom "q"
r = Atom "r"

-- Find better way to do this
listProps :: [ (String, Proposition) ]
listProps = [ ("p", p), ("q", q), ("r", r) ]

main :: IO()
main = do
{-
  putStrLn "These are the assigned values of the propositions"
  mapM_ (\(name, prop) -> putStrLn $ name ++ ": " ++ show (eval v prop)) listProps

  print $ eval v (p :-> p) -- True since P -> P for all P
  print $ eval v p -- Returns the value of p
  print $ eval v $ p :-> q -- Only false if ~q and p
  print $ eval v $ Not $ Not $ p -- Double Negation returns p
  print $ eval v $ Or (Not p) p -- True or False = True
-}

  putStrLn "\nDoes P follow from P? (Should be True):"
  print $ follows p [p]
  
  putStrLn "\nDoes P follow from (Q->P), Q?"
  print $ follows p [(q:->p),q]

  putStrLn "\nFrom P, (P->Q), (Q->R) does it follow that R (1) and (P->R) (2)?"
  print $ follows r [(p:->q), (q:->r), p] -- Transitivity
  print $ follows (p:->r) [(p:->q), (q:->r)] -- Should be true

  putStrLn "\nChecks if P contradicts with Not P (Returns the contradictions)"
  print $ contradicts [p, Not p]
  putStrLn "\nChecks if P contradicts with P"
  print $ contradicts [p, p]

  putStrLn "\n parseString, does p->q follow from p->r and r->q? (Input is a string)"
  case parseString "p->q" of
    Left err -> putStrLn ("Parse error: "++ show err)
    Right prop -> print $ follows prop [p:->r, r:->q]
