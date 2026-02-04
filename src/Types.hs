-- Types.hs
module Types where

data Proposition -- Any type for the variable x in P(x)
  = Atom String -- Propositions like P(x) (just that), useful for placeholders
  -- Colon needed to infix it
  | (:->) Proposition Proposition
  | Iff Proposition Proposition -- If and only if
  | And Proposition Proposition
  | Or Proposition Proposition 
  | Not Proposition
  deriving (Eq, Show)
infixr 1 :->   -- right-associative, low precedence
infixr 1 `Iff`

-- Setting truth values to propositions, the numbers will be associated later
-- Set this way so you always know if the proposition will be true or false
v :: Int -> Bool
-- These two are permanent
v 0 = False
v 1 = True
v n
  | n `mod` 2 == 0 = False
  | otherwise = True
