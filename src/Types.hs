-- Types.hs
module Types where

data Elem
  = Number Integer
  | Name String
  deriving (Eq, Show)

data Set
  = Eset -- empty set
  | PointSet [Elem] -- Custom sets as a list of elems, could not think of a better name
  | NN          -- ℕ
  | ZZ          -- ℤ
  | Union Set Set
  | Intersect Set Set
  deriving (Eq, Show)

data Proposition
  = Atom String -- Propositions like P (just that), useful for placeholders
  | Axiom Proposition -- Like atom but these are asumed to be true and are not Strings
  | (:->) Proposition Proposition -- Colon needed bc -> is already a keyword in haskell
  | And Proposition Proposition
  | Or Proposition Proposition
  | Not Proposition
  | In Elem Set                    -- x ∈ ℕ
  | Equal Set Set -- Also work for elements if they are in a PointSet
  
  -- These just make sense in some sets
  | Greater Elem Elem
  | SubSet Set Set
  deriving (Eq, Show)
infixr 1 :->   -- right-associative, low precedence
