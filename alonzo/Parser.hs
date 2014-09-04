module Alonzo.Parser where

import           Data.Attoparsec.Text
import qualified Alonzo.Syntax as Syntax

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
  _ <- char '\\'
  n <- identifier
  _ <- char '.'
  e <- expression
  return $ Syntax.Abstraction n e

application :: Parser Syntax.Expression
application = do
  a <- abstraction
  _ <- char ' '
  e <- expression
  return $ Syntax.Application a e
