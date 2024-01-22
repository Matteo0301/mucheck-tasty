{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeSynonymInstances #-}

module Test.MuCheck.TestAdapter.TastyAdapter where

import Test.MuCheck.TestAdapter
import Test.Tasty
import Test.Tasty.Runners

import Data.Typeable

deriving instance Typeable Bool
type TastySummary = Bool

instance Summarizable TastySummary where
    testSummary _mutant _test result =
        Summary $ _ioLog result
    isSuccess = id
    isFailure = not . isSuccess
    isOther _ = False

data TastyRun = TastyRun String

instance TRun TastyRun TastySummary where
    genTest _m tstfn = "evalTastyTree " ++ tstfn
    getName (TastyRun str) = str
    toRun s = TastyRun s

    summarize_ _m = testSummary :: Mutant -> TestStr -> InterpreterOutput TastySummary -> Summary
    success_ _m = isSuccess :: TastySummary -> TastySummary
    failure_ _m = isFailure :: TastySummary -> TastySummary
    other_ _m = isOther :: TastySummary -> TastySummary

evalTastyTree :: TestTree -> IO Bool
evalTastyTree tree = do
    opts <- parseOptions defaultIngredients tree

    case tryIngredients defaultIngredients opts tree of
        Nothing -> return False
        Just act -> act