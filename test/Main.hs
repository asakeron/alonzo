module Main where

import Prelude hiding (read)
import Test.Hspec

import Lambda

main :: IO ()
main = hspec $ do
  let x  = Symbol 'x'
      id = Abstraction x x
      y = Evaluation id (Symbol 'y')
  describe "read" $ do
    it "parses a Lambda term" $ do
      read "x"         `shouldBe` x
      read "\\x.x"     `shouldBe` id
      read "(\\x.x y)" `shouldBe` y
  describe "eval" $ do
    it "normalizes a lambda term" $ do
      eval [] x  `shouldBe` Symbol 'x'
      eval [] id `shouldBe` Abstraction x x
      eval [] y  `shouldBe` Symbol 'y'
