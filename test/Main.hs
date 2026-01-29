module Main (main) where

import Test.HUnit
import Types
import Eval

-- Copied from main
v :: Int -> Bool
-- These two are permanent
v 0 = False
v 1 = True

v 2 = False
v 3 = True
v _ = False -- Catch all, could make this a Nothing

-- This makes a an Int type
-- If x = Atom i = y then x = y in every evaluation
p, q, r :: Proposition Int
p = Atom 1
q = Atom 2
r = Atom 3

-- assertBool expects the expresion to be True
test1 :: Test
test1 = TestCase $ assertBool "Atom 0 Should be False"
  (not $ eval v (Atom 0))

test2 :: Test
test2 = TestCase $ assertBool "Should be True since P -> P for any P"
  (eval v $ p :-> p)

test3 :: Test
test3 = TestCase $ assertBool "Double negation of Atom 1 should be true"
  (not $ eval v $ Not $ Not (Atom 1))

test4 :: Test
test4 = TestCase $ assertBool "True Or False should be True for any value of P"
  (eval v $ Or (Not p) p)

transitivity :: Test
transitivity = TestCase $ assertBool "If both (P->Q) and (Q->R) are true then \
  \ (P->R) Should be true"
    (eval v $ (p :-> q) `And` (q :->r) :-> (p:->r))

allTests :: Test
allTests = TestList
  [ test1, test2, test3, test4, transitivity ]

main :: IO()
main = do
  counts <- runTestTT allTests
  print counts
