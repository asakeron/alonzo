module Lambda.AST where

data Expression
  = Symbol Char
  | Abstraction Expression Expression
  | Evaluation Expression Expression
  deriving Eq

instance Show Expression where
  show (Symbol x)          = [x]
  show (Abstraction e1 e2) = "\\" <> show e1 <> "." <> show e2
  show (Evaluation f x)    = "(" <> show f <> " " <> show x <> ")"
