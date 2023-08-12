module Lambda.AST where

import Data.Int

data Expression
  = Symbol Char
  | Abstraction Expression Expression
  | Evaluation Expression Expression
  | Integer Int64
  | Decimal Double
  deriving Eq

instance Show Expression where
  show (Symbol x)          = [x]
  show (Abstraction e1 e2) = "\\" <> show e1 <> "." <> show e2
  show (Evaluation f x)    = "(" <> show f <> " " <> show x <> ")"
  show (Integer i)         = show i
  show (Decimal d)         = show d
