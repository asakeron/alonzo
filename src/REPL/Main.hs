module Main where

import System.Console.Haskeline
import qualified Data.Text          as T
import qualified Alonzo.Parser      as P
import qualified Alonzo.Interpreter as I

main :: IO ()
main = runInputT defaultSettings repl
  where
    repl :: InputT IO ()
    repl = do
      expression <- getInputLine ">"
      case expression of
        Just input -> do
                        _ <- outputStrLn $ case P.parse $ T.pack input of
                                             Right parsed -> case I.eval parsed of
                                                               Right r  -> show r
                                                               Left err -> err
                                             Left err     -> err
                        repl
        Nothing    -> return ()
