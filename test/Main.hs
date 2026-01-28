module Main (main) where

import Test.HUnit
import Types
import Eval

-- assertBool expects the expresion to be True

test1 :: Test
test1 = TestCase $ assertBool "Atoms should be False by default"
  (not $ eval $ Atom "P")

test2 :: Test
test2 = TestCase $ assertBool "Since P is False, P -> Q should be True"
  (eval $ (Atom "P") :-> (Atom "Q"))

test3 :: Test
test3 = TestCase $ assertBool "Double negation, and since atoms are False: False"
  (not $ eval $ Not $ Not $ Atom "P")

test4 :: Test
test4 = TestCase $ assertBool "True Or False should be True"
  (eval $ Or (Not (Atom "P")) (Atom "Q"))

test5 :: Test
test5 = TestCase $ assertBool "NN should not be empty according to IntAxioms"
  (not $ eval (Equal NN Eset))

allTests :: Test
allTests = TestList
  [ test1, test2, test3, test4, test5 ]

main :: IO()
main = do
  counts <- runTestTT allTests
  print counts
