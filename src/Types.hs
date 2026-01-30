-- Types.hs
module Types where
--import Data.Ratio -- For the module operator

data Proposition a -- Any type for the variable x in P(x)
  = Atom a -- Propositions like P(x) (just that), useful for placeholders
  -- Colon needed bc -> is already a keyword in haskell
  | (:->) (Proposition a) (Proposition a)
  | And (Proposition a) (Proposition a)
  | Or (Proposition a) (Proposition a)
  | Not (Proposition a)
  deriving (Eq, Show)
infixr 1 :->   -- right-associative, low precedence

-- Setting truth values to propositions, the numbers will be associated later
-- Set this way so you always know if the proposition will be true or false
v :: Int -> Bool
-- These two are permanent
v 0 = False
v 1 = True
v n
  | n `mod` 2 == 0 = False
  | otherwise = True
