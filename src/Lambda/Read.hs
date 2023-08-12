module Lambda.Read where

import Text.Megaparsec
import Text.Megaparsec.Char
import Text.Megaparsec.Char.Lexer
import Lambda.AST

read :: String -> Expression
read ts = case parse parse_ "" ts of
            Left _  -> Symbol '\0'
            Right e -> e

parse_ :: Parser Expression
parse_ = parseSymbol_ <|> parseAbstraction_ <|> parseEvaluation_

parseSymbol_ :: Parser Expression
parseSymbol_ = Symbol <$> letterChar

parseAbstraction_ :: Parser Expression
parseAbstraction_ = do
  _ <- char '\\'
  symbol <- parseSymbol_
  _ <- char '.'
  Abstraction symbol <$> parse_

parseEvaluation_ :: Parser Expression
parseEvaluation_ = do
  _ <- char '('
  e1 <- parse_
  _ <- char ' '
  Evaluation e1 <$> parse_

parseInteger_ :: Parser Expression
parseInteger_ = Integer <$> decimal

parseDecimal_ :: Parser Expression
parseDecimal_ = Decimal <$> float

instance Read Expression where
  readsPrec _ str = [(Lambda.Read.read str, "")]

type Parser a = Parsec () String a
