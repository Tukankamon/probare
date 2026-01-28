-- Types.hs
module Types where

data Elem
  = Number Integer
  | Name String
  deriving (Eq, Show)

data Set
  = Eset -- empty set
  | NN          -- ℕ
  | ZZ          -- ℤ
  | Union Set Set
  | Intersect Set Set
  deriving (Eq, Show)

data Proposition
  = Atom String -- Propositions like P (just that)
  | Proposition :-> Proposition -- Colon needed bc -> is already a keyword in haskell
  | And Proposition Proposition
  | Or Proposition Proposition
  | Not Proposition
  | In Elem Set                    -- x ∈ ℕ
  
  -- These just make sense in some sets
  | Equal Elem Elem
  | Greater Elem Elem
  deriving (Eq, Show)
infixr 1 :->   -- right-associative, low precedence
