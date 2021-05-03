module Lambda.Eval where

import Control.Applicative

import Lambda.AST

type Environment = [(Expression, Expression)]

eval :: Environment -> Expression -> Expression
eval e s@(Symbol _) = case lookup s e of
                        Just expr -> expr
                        _         -> s
eval e a@(Abstraction
           (Symbol _) _) = a
eval e (Evaluation
        (Abstraction
         p@(Symbol _) b)
        x)               = eval ([(p, x)] <> e) b
eval _ _ = Symbol '\0'
