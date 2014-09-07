module Alonzo.Interpreter (
  eval) where

import qualified Alonzo.Syntax as Syntax
import qualified Data.Map      as Map

eval :: Syntax.Expression -> Either String Syntax.Expression
eval e = evalWithEnv e Map.empty

evalWithEnv :: Syntax.Expression -> Map.Map String Syntax.Expression -> Either String Syntax.Expression
evalWithEnv a@(Syntax.Abstraction _ _) _   = return a
evalWithEnv n@(Syntax.Name identifier) env = return $ Map.findWithDefault n identifier env
evalWithEnv (Syntax.Application f arg) env = do
  abstraction <- evalWithEnv f env
  case abstraction of
   (Syntax.Abstraction name body) -> evalWithEnv body $ Map.insert name arg env
   _                              -> Left $ "Error: trying to apply " ++ show f ++
                                     ", which is not an abstraction, to argument "
                                     ++ show arg ++ "."
