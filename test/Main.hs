module Main (main) where

import Test.HUnit
import Types
import Eval

-- If x = Atom i = y then x = y in every evaluation
p, q, r :: Proposition
p = Atom "p"
q = Atom "q"
r = Atom "r"

{-
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
-}

main :: IO()
main = do
  putStrLn "Tests not done yet"
  --counts <- runTestTT allTests
  --print counts
