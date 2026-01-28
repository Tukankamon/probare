-- List of logical axioms like P -> P, or (P -> Q) -> (~Q -> ~P)
-- https://en.wikipedia.org/wiki/Hilbert_system
module Logic where

import Types

-- P -> P
isIdentity :: Proposition -> Bool
isIdentity (p :-> q) = p == q -- Returns p == q (True/False)
isIdentity _ = False

-- (P -> Q) -> (~P -> ~Q)
-- Logically wrong TODO
isContraPositive :: Proposition -> Bool
isContraPositive ((Not q) :-> (Not p)) = True
isContraPositive _ = False

isLogicAxiom :: Proposition -> Bool
isLogicAxiom p
  | isIdentity p = True
  | isContraPositive p = True
  | otherwise = False
