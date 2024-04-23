{-# LANGUAGE InstanceSigs #-}

module Test.Tasty.MuCheck where

import Data.Typeable
import Test.MuCheck
import Test.MuCheck.AnalysisSummary
import Test.MuCheck.Interpreter
import Test.MuCheck.TestAdapter
import Test.MuCheck.TestAdapter.TastyAdapter
import Test.Tasty.Providers

testFile :: String -> String -> Double -> TestTree
testFile testName fileName threshold = singleTest testName $ TestCase ((mucheck (toRun fileName :: TastyRun) []), threshold)

newtype TestCase = TestCase ((IO (MAnalysisSummary, [MutantSummary])), Double)
    deriving (Typeable)

instance IsTest TestCase where
    run _ (TestCase (compute, threshold)) _ = do
        (analysisSummary, _) <- compute
        let numSucceeded = (fromIntegral (_maAlive analysisSummary) :: Double) / (fromIntegral (_maNumMutants analysisSummary) :: Double)
        return $ if numSucceeded > threshold then testFailed $ show analysisSummary else testPassed $ show analysisSummary

    testOptions = return []