module Main (main) where

import Test.Framework (defaultMain, testGroup)
import Test.Framework.Providers.QuickCheck2
import Test.Framework.Providers.HUnit
import Test.HUnit

main = defaultMain [
         testGroup "Silly tests" [
            testCase     "sum"           (2 + 2 @?= 4)
         ,  testProperty "commutativity" prop_commutativity
         ]
  ]

prop_commutativity     :: Int -> Int -> Bool
prop_commutativity x y =  x + y == y + x
