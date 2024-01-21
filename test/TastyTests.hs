module TastyTests (test, evalTastyTree) where

import Test.Tasty
import Test.Tasty.HUnit
import Test.Tasty.Runners

a = 1 + 1

{-# ANN test "Test" #-}
test :: TestTree
test =
    testCase "List comparison (different length)" $
        a @?= 2

evalTastyTree :: TestTree -> IO Bool
evalTastyTree tree = do
    opts <- parseOptions defaultIngredients tree

    case tryIngredients defaultIngredients opts tree of
        Nothing -> return False
        Just act -> act