module Alonzo.Interpreter where

import qualified Alonzo.Syntax as Syntax
import qualified Data.Map      as Map

eval :: Either String Syntax.Expression -> Map.Map String Syntax.Expression -> Either String Syntax.Expression
eval err@(Left _) _                             = err
eval abst@(Right (Syntax.Abstraction _ _)) _    = abst
eval name@(Right (Syntax.Name identifier)) env  = let value = Map.lookup identifier env in
                                                    case value of
                                                      Just expression -> Right expression
                                                      Nothing         -> name

eval (Right (Syntax.Application f arg)) env    = let abstraction = eval (Right f) env in
                                                   case abstraction of
                                                     Right (Syntax.Abstraction name body) -> eval (Right body) $ Map.insert name arg env
                                                     _                                    -> Left $ "Error: trying to apply " ++ show f ++
                                                                                                    ", which is not an abstraction, to argument " ++
                                                                                                    show arg ++ "."
