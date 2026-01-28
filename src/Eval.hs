-- Eval.hs
module Eval where

import Types
import IntAxioms

-- Should probably find a way to make this list more convenient
extraAxioms :: [Proposition]
extraAxioms = [ Not $ Equal Eset ZZ ]

isAxiom :: Proposition -> Bool
isAxiom p
  | p `elem` naturalAxioms = True
  | p `elem` extraAxioms = True
  | otherwise = False

-- Final output of if a prop is true
eval :: Proposition -> Bool
eval p
  | isAxiom p = True
eval (Axiom _) = True -- Axioms are asumed to be true
eval (p :-> q) = (not $ eval p) || eval q -- Only false if p -> ~q
eval (Not p) = not $ eval p
eval (And p q) = (eval p) && (eval q)
eval (Or p q) = (eval p) || (eval q)
eval _ = False -- Not necesarily false, just doesnt follow from the axioms
