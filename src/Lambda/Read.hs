module Lambda.Read where

import Text.Parsec

import Lambda.AST
--
read :: String -> Expression
read ts = case parse parse_ "" ts of
            Left _  -> Symbol '\0'
            Right e -> e

parse_ :: Parsec String () Expression
parse_ = parseSymbol_ <|> parseAbstraction_ <|> parseEvaluation_

parseSymbol_ :: Parsec String () Expression
parseSymbol_ = Symbol <$> letter

parseAbstraction_ :: Parsec String () Expression
parseAbstraction_ = do
  _ <- char '\\'
  symbol <- parseSymbol_
  _ <- char '.'
  Abstraction symbol <$> parse_

parseEvaluation_ :: Parsec String () Expression
parseEvaluation_ = do
  _ <- char '('
  e1 <- parse_
  _ <- char ' '
  Evaluation e1 <$> parse_


instance Read Expression where
  readsPrec _ str = [(Lambda.Read.read str, "")]
