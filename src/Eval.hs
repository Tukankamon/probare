-- Eval.hs
module Eval where

import Types

-- Evaluates an expression where v is decides if any proposition P is T/F
eval :: (a -> Bool) -> Proposition a -> Bool
eval v (Atom x) = v x
eval v (Not p) = not (eval v p)
eval v (p `And` q) = eval v p && eval v q
eval v (p `Or` q) = eval v p || eval v q
eval v (p :-> q) = not (eval v p) || eval v q
eval v _ = False -- Just in case
