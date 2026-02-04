-- Eval.hs
module Eval where

import Types
import Data.List (nub) -- Removes duplicate elements in list

{- BROKEN after removing a type from definition, low prio
eval :: (a -> Bool) -> Proposition a -> Bool
eval truth (Atom x) = truth x
eval truth (Not p) = not (eval truth p)
eval truth (p `And` q) = eval truth p && eval truth q
eval truth (p `Or` q) = eval truth p || eval truth q
eval truth (p :-> q) = not (eval truth p) || eval truth q
eval truth (p `Iff` q) = eval truth (p:->q) && eval truth (q:->p)
eval truth _ = False -- Just in case
-}

-- https://en.wikipedia.org/wiki/Natural_deduction
deduceOnce :: [Proposition] -> [Proposition]
deduceOnce [] = []
deduceOnce premises =
  nub $ premises ++
    -- Modus ponens, if p and p->q then q
    [q | p <- premises, p:->q <- premises]++
    [q | And q _ <- premises]++
    [q | And _ q <- premises]++ -- And is not commutative so i gotta do this
    -- Does not construct Or and And propositions since that would be an infinite loop
    -- Maybe add that directly into follows
    [q | Or q p <- premises, Not p <- premises]++
    [q | Or p q <- premises, Not p <- premises]++ -- Same as with And
    -- Might fail for implications like (p->q)->r
    [p:->q | p:->r <-premises, r:->q <- premises]++ -- Not "pure" natural deduction
    [p `Iff` q | p:->q <- premises, q:->p <- premises]

-- Runs deduceOnce until there is no more to deduce
-- Returns the complete exhausted list of propositions, no more can be deduced
exhaust :: [Proposition] -> [Proposition]
exhaust premises =
  let newPremises = deduceOnce premises
  in 
    if newPremises == premises
      then premises
    else exhaust newPremises

-- Not dependent on the truth value given by eval
follows :: Proposition -> [Proposition] -> Bool
--IDK if there is a better way to do this
follows (And p q) premises = follows p premises && follows q premises
follows (Or p q) premises = follows p premises || follows q premises
follows (Not (Not p)) premises = follows p premises
follows goal premises
  | goal `elem` premises = True -- P follows from P
  | otherwise = goal `elem` (exhaust premises)

-- TODO, maybe separate the sets of contradictions
contradicts :: [Proposition] -> [Proposition]
contradicts list = [ p | p <- list , follows p list && follows (Not p) list]
