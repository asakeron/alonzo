module Alonzo.Parser (
  Alonzo.Parser.parse) where

import           Data.Attoparsec.Text
import qualified Data.Text     as T
import qualified Alonzo.Syntax as Syntax

parse :: T.Text -> Either String Syntax.Expression
parse = parseOnly expression

expression :: Parser Syntax.Expression
expression = choice [application, abstraction, name]

identifier :: Parser [Char]
identifier = do
    l <- letter
    return $ l : []

name :: Parser Syntax.Expression
name = do
  n <- identifier
  return $ Syntax.Name n

abstraction :: Parser Syntax.Expression
abstraction = do
  _ <- choice [char '\\', char 'λ'] 
  n <- identifier
  _ <- char '.'
  e <- expression
  return $ Syntax.Abstraction n e

application :: Parser Syntax.Expression
application = do
  _ <- char '('
  a <- expression
  _ <- char ' '
  e <- expression
  _ <- char ')'
  return $ Syntax.Application a e
