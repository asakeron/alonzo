module Main where

import qualified Data.Text          as T
import qualified Data.Text.IO       as TextIO
import qualified Alonzo.Parser      as Parser
import qualified Alonzo.Interpreter as Interpreter

main :: IO ()
main = do
  expression <- TextIO.getLine
  _          <- TextIO.putStrLn $ case Parser.parse expression of
                                    Left err         -> T.pack err
                                    Right parsed     -> case Interpreter.eval parsed of
                                                          Right evaluated -> T.pack $ show evaluated
                                                          Left  err       -> T.pack err
  main
