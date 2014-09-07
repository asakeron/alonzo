module Alonzo.Interpreter where

import qualified Alonzo.Syntax as Syntax
import qualified Data.Map      as Map

eval :: Syntax.Expression -> Map.Map String Syntax.Expression -> Either String Syntax.Expression
eval a@(Syntax.Abstraction _ _) _   = return a
eval n@(Syntax.Name identifier) env = return $ Map.findWithDefault n identifier env
eval (Syntax.Application f arg) env = do
                                        abstraction <- eval f env
                                        case abstraction of
                                          (Syntax.Abstraction name body) -> eval body $ Map.insert name arg env
                                          _                              -> Left $ "Error: trying to apply " ++ show f ++
                                                                                   ", which is not an abstraction, to argument "
                                                                                   ++ show arg ++ "."
