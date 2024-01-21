{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TypeSynonymInstances #-}

module Test.MuCheck.TestAdapter.TastyAdapter where

import Test.MuCheck.TestAdapter
import Test.Tasty

import Data.Typeable

deriving instance Typeable Bool


instance Summarizable Bool where
    testSummary _mutant _test result =
        Summary $ _ioLog result
    isSuccess = id
    isFailure = not . isSuccess
    isOther _ = False

data TastyRun = TastyRun String

instance TRun TastyRun Bool where
    genTest _m tstfn = "evalTastyTree " ++ tstfn
    getName (TastyRun str) = str
    toRun s = TastyRun s

    summarize_ _m = testSummary :: Mutant -> TestStr -> InterpreterOutput Bool -> Summary
    success_ _m = isSuccess :: Bool -> Bool
    failure_ _m = isFailure :: Bool -> Bool
    other_ _m = isOther :: Bool -> Bool