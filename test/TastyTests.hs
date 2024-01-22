module TastyTests (test) where

import Test.Tasty
import Test.Tasty.HUnit

import Test.MuCheck.TestAdapter.TastyAdapter

a :: Integer
a = 1 + 1

{-# ANN test "Test" #-}
test :: TestTree
test =
    testCase "List comparison (different length)" $
        a @?= 2