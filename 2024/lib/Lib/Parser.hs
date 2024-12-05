module Lib.Parser where

import           Control.Applicative
import           Data.List           (isPrefixOf)
import           Prelude             hiding (any)

data ParserErr = ParserErr {message :: String, offset :: Int}
  deriving (Eq, Show)

newtype Parser a = Parser {runParser :: String -> Either ParserErr (a, String) }

instance Functor Parser where
  fmap f (Parser runner) = Parser $ \bs -> do
    (struct, bs') <- runner bs
    return (f struct, bs')

instance Applicative Parser where
  pure x = Parser $ \bs -> Right(x, bs)
  (Parser runnerA) <*> (Parser runnerB) = Parser $ \bs -> do
    (f, bs1) <- runnerA bs
    (struct, bs2) <- runnerB bs1
    return (f struct, bs2)

instance Monad Parser where
  (Parser runner) >>= f = Parser $ \bs -> do
    (struct, bs') <- runner bs
    runParser (f struct) bs'

instance MonadFail Parser where
  fail s = Parser . const $ Left (ParserErr s 0)

instance Alternative Parser where
  some v = s
    where
      m = s <|> pure []
      s = (:) <$> v <*> m
  many v = m
    where
      m = s <|> pure []
      s = (:) <$> v <*> m
  empty = fail ""
  (Parser x) <|> (Parser y) = Parser $ \s ->
    case x s of
      Right x  -> Right x
      Left errA -> do
        case y s of
          Right x   -> Right x
          Left errB -> Left (deepestErr errA errB)

deepestErr :: ParserErr -> ParserErr -> ParserErr
deepestErr a b
  | offset a > offset b = b
  | otherwise = a


any :: Parser Char
any = Parser charP
  where
    charP bs
      | bs == "" = Left (ParserErr "nothing to read" 0)
      | otherwise = Right (head bs, tail bs)

char :: Char -> Parser Char
char c = Parser charP
  where
    charP bs
      | bs == "" = Left (ParserErr "nothing to read" 0)
      | head bs == c = Right (c, tail bs)
      | otherwise = Left (ParserErr (errString bs) (length bs))
    errString bs = [head bs] ++ " does not match " ++ [c] ++ " in " ++ bs


charIn :: [Char] -> Parser Char
charIn opts = Parser charP
  where
    charP bs
      | bs == "" = Left (ParserErr "nothing to read" 0)
      | head bs `elem` opts = Right (head bs, tail bs)
      | otherwise = Left (ParserErr (errString bs) (length bs))
    errString bs = [head bs] ++ " not in " ++ opts ++ " in " ++ bs

space :: Parser Char
space = char ' '

ss :: Parser String
ss = some space

string :: String -> Parser String
string = mapM char

stringWithChars :: [Char] -> Parser String
stringWithChars s = some (charIn s)

digit :: Parser Char
digit = charIn ['0' .. '9']

integer :: Parser [Char]
integer = stringWithChars ['0' .. '9']

til :: String -> Parser String
til d = Parser $ \x -> do
  if x == ""
    then Left (ParserErr "nothing to read" 0)
    else
      if d `isPrefixOf` x
        then Right (d, drop (length d) x)
        else do
          (c, rest) <- runParser any x
          (cs, rest') <- runParser (til d) rest
          return (c:cs, rest')

