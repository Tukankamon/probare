-- Types.hs
module Types where

data Proposition a -- Any type for the variable x in P(x)
  = Atom a -- Propositions like P(x) (just that), useful for placeholders
  -- Colon needed bc -> is already a keyword in haskell
  | (:->) (Proposition a) (Proposition a)
  | And (Proposition a) (Proposition a)
  | Or (Proposition a) (Proposition a)
  | Not (Proposition a)
  deriving (Eq, Show)
infixr 1 :->   -- right-associative, low precedence
