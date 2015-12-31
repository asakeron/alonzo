module Language.Alonzo.Interpreter (
  eval) where

import qualified Language.Alonzo.Syntax as S
import qualified Data.Map               as M

eval :: S.Expression -> Either String S.Expression
eval e = evalWithEnv e M.empty

evalWithEnv :: S.Expression -> M.Map String S.Expression -> Either String S.Expression
evalWithEnv a@(S.Abstraction _ _) _   = return a
evalWithEnv n@(S.Name identifier) env = return $ M.findWithDefault n identifier env
evalWithEnv (S.Application f arg) env = do
  abstraction <- evalWithEnv f env
  case abstraction of
   (S.Abstraction name body) -> evalWithEnv body $ M.insert name arg env
   _                         -> Left $ "Error: trying to apply " ++ show f ++
                                       ", which is not an abstraction, to argument "
                                       ++ show arg ++ "."

