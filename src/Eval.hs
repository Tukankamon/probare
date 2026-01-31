-- Eval.hs
module Eval where

import Types

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

-- Checks to see if a proposition is true if the list
-- of prepositions is true, aka if it follows from them
-- It is "proposition generic" so when it says p, p is not a set Proposition
-- With a true or false value from v
-- If for example you want to show that Q follows from P->Q
-- Your premises need to be: [P, (P:->Q)]. Not having P will make it false
follows :: Eq a => [Proposition a] -> Proposition a -> Bool
follows premises p
  | p `elem` premises = True -- P follows from P
follows premises (Not p)
  | follows premises p = False
follows premises (Or p q) = follows premises p || follows premises q
follows premises (And p q) = follows premises p && follows premises q
follows premises (p :-> q) = follows (p : premises) q --To allow transitivity
follows premises p = or [ follows premises antecedent
                  | (antecedent :-> consequent) <- premises --take only the implications
                  -- Filters only those that are (X:->P) and evaluates follow on them
                  , consequent == p ]

-- Returns if in a list of propositions any of them contradict
-- TODO make it so it tells you which props contradict
contradicts :: Eq a => [Proposition a] -> Bool
contradicts list = or [ follows list p && follows list (Not p)
                      | p <- list ]
