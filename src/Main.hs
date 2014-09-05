module Main where

import qualified Data.Text.IO       as TextIO
import qualified Alonzo.Parser      as Parser
import qualified Alonzo.Interpreter as Interpreter
import qualified Data.Map           as Map

main :: IO ()
main = do
  expression <- TextIO.getLine
  _          <- putStrLn $ case Parser.parse expression of
                             Left err         -> err
                             Right parsed     -> case Interpreter.eval (Right parsed) Map.empty of
                                                   Right evaluated -> show evaluated
                                                   Left  err       -> err
  main
