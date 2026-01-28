module IntAxioms where

import Types
-- TODO
-- Axioms that are true if the proposition (In (Elem x) NN) is true

-- List of true statements for every every element in NN
naturalAxioms :: [Proposition]
naturalAxioms = [
  Axiom $ Not $ Equal NN Eset ]


