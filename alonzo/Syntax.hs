module Alonzo.Syntax where

data Expression = Name String
                | Abstraction String Expression
                | Application Expression Expression

instance Show Expression where
  show (Name name)             = name
  show (Abstraction name body) = "\\" ++ name ++ "." ++ show body
  show (Application exp1 exp2) = show exp1 ++ " " ++ show exp2

