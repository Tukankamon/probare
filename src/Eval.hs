-- Eval.hs
module Eval where

import Types
import Data.List (nub) -- Removes duplicate elements in list

-- Evaluates an expression where f (aka v) is decides if any proposition P is T/F
-- This is not used however for stuff like P and (P:->Q) :-> Q
-- That is what follows is for
eval :: (a -> Bool) -> Proposition a -> Bool
eval f (Atom x) = f x
eval f (Not p) = not (eval f p)
eval f (p `And` q) = eval f p && eval f q
eval f (p `Or` q) = eval f p || eval f q
eval f (p :-> q) = not (eval f p) || eval f q
eval f _ = False -- Just in case

-- Returns propositions that can be derived from the premises after one iteration
-- https://en.wikipedia.org/wiki/Natural_deduction
deduceOnce :: Eq a => [Proposition a] -> [Proposition a]
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
    [p:->q | p:->r <-premises, r:->q <- premises] -- Not "pure" natural deduction

-- Runs deduceOnce until there is no more to deduce
-- Returns the complete exhausted list of propositions, no more can be deduced
exhaust :: Eq a => [Proposition a] -> [Proposition a]
exhaust premises =
  let newPremises = deduceOnce premises
  in 
    if newPremises == premises
      then premises
    else exhaust newPremises

-- Not dependent on the truth value given by eval
follows :: Eq a => Proposition a -> [Proposition a] -> Bool
follows goal premises
  | goal `elem` premises = True -- P follows from P
  -- Checks if goal is in the list of all derivable propositions
  | otherwise = goal `elem` (exhaust premises)

-- Returns if in a list of propositions any of them contradict
-- TODO make it so it tells you which props contradict
contradicts :: Eq a => [Proposition a] -> Bool
contradicts list = or [ follows p list && follows (Not p) list 
                      | p <- list ]
