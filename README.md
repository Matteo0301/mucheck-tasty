# mucheck-tasty
Tasty adapter for MuCheck

To use this adapter, just follow the usual process you would use to run MuCheck, but keep in mind that you need to import the adapter in your test files. After that you can mark the tests you want with the {-# ANN testFn "Test" #-} annotation.