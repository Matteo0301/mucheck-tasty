module Main where

import Test.MuCheck
import Test.MuCheck.TestAdapter
import Test.MuCheck.TestAdapter.TastyAdapter

runMuCheck file = do
    (msum, _tsum) <- mucheck (toRun file :: TastyRun) []
    print msum

main :: IO ()
main = runMuCheck "test/TastyTests.hs"