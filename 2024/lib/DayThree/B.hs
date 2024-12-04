module DayThree.B where

import           Control.Applicative
import           Lib.Parser
import           Prelude             hiding (any)

parseGuardedMemory :: String -> Int
parseGuardedMemory "" = 0
parseGuardedMemory a = case genericParse a of
  Left _          -> parseGuardedMemory (tail a)
  Right (p, "")   -> uncurry (*) p
  Right (p, rest) -> uncurry (*) p + parseGuardedMemory rest

genericParse :: String -> Either ParserErr ((Int, Int), String)
genericParse a = case result of
  Left s        -> Left s
  Right (p, bs) -> Right (p, bs)
  where
    result = runParser guardedMulParser a

guardedMulParser :: Parser (Int, Int)
guardedMulParser = dontThenDo <|> mulParser

dontThenDo :: Parser (Int, Int)
dontThenDo = do
  string "don't()"
  til "do()"
  return (0, 0)

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

