module Main where

import Test.Tasty
import Test.Tasty.MuCheck
import Test.Tasty.MuCheck (testFile)

main :: IO ()
main = defaultMain tests

tests = testGroup "Tests" [testFile "test/TastyTests.hs" "test/TastyTests.hs" (0.5)]