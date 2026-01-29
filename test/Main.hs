module Main (main) where

import Test.HUnit
import Types
import Eval

-- Broken since changing eval

-- assertBool expects the expresion to be True
test1 :: Test
test1 = TestCase $ assertBool "Atoms should be False by default"
  (not $ eval p)

test2 :: Test
test2 = TestCase $ assertBool "Since P is False, P -> Q should be True"
  (eval $ p :-> p)

test3 :: Test
test3 = TestCase $ assertBool "Double negation, and since atoms are False: False"
  (not $ eval $ Not $ Not p)

test4 :: Test
test4 = TestCase $ assertBool "True Or False should be True"
  (eval $ Or (Not p) q)

{-
axiom :: Test
axiom = TestCase $ assertBool "NN should not be empty according to IntAxioms"
  (not $ eval (Equal NN Eset))
-}

transitivity :: Test
transitivity = TestCase $ assertBool "If both (P->Q) and (Q->R) are true then \
  \ (P->R) Should be true"
    (eval $ (Axiom $ (p :-> q) `And` (q :->r)) :-> (p:->r))

allTests :: Test
allTests = TestList
  [ test1, test2, test3, test4, transitivity ]

main :: IO()
main = do
  counts <- runTestTT allTests
  print counts
