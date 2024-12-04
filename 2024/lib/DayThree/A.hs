module DayThree.A where

import           Control.Applicative
import           Lib.Parser

parseMemory :: String -> Int
parseMemory "" = 0
parseMemory a = case genericParse a of
  Left _          -> parseMemory (tail a)
  Right (p, "")   -> uncurry (*) p
  Right (p, rest) -> uncurry (*) p + parseMemory rest

genericParse :: String -> Either ParserErr ((Int, Int), String)
genericParse a = case result of
  Left s        -> Left s
  Right (p, bs) -> Right (p, bs)
  where
    result = runParser mulParser a

mulParser :: Parser (Int, Int)
mulParser = do
  string "mul("
  num <- numberParser
  char ','
  num' <- numberParser
  char ')'
  return (num, num')

numberParser :: Parser Int
numberParser =
    read <$> (three <|> two <|> one)
  where
    one   = (:[]) <$> digit
    two   = (:) <$> digit <*> ((:[]) <$> digit)
    three = (:) <$> digit <*> ((:) <$> digit <*> ((:[]) <$> digit))

