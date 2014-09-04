module Main (main) where

import Test.Framework (defaultMain, testGroup)
import Test.Framework.Providers.QuickCheck2
import Test.Framework.Providers.HUnit
import Test.HUnit

main :: IO ()
main = defaultMain [
         testGroup "Silly tests" [
            testCase     "sum"           case_sum
         ,  testProperty "commutativity" prop_commutativity
         ]
  ]
case_sum :: Assertion
case_sum = a + a @?= b
           where
               a :: Int
               a = 2
               b :: Int
               b = 4

prop_commutativity     :: Int -> Int -> Bool
prop_commutativity x y =  x + y == y + x
