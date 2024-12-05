module DayFour.A where

import           Data.List  (transpose)
import           Lib.Parser

countXmas :: String -> Int
countXmas = sum
            . map parsePuzzle
            . concat
            . (\ls -> [
                        ls, -- lef to right
                        map reverse ls, -- right to left
                        transpose ls, -- top to bottom
                        map reverse $ transpose ls, -- bottom to top
                        diagonal ls, -- top left to bottom right
                        map reverse $ diagonal ls, -- bottom right to top left
                        diagonal' ls, -- top right to bottom left
                        map reverse $ diagonal' ls -- bottom left to top right
                        ]
            )
            . lines
  where
    countXmas = sum . map parsePuzzle

diagonal :: [[a]] -> [[a]]
diagonal rows = [ [rows !! i !! (d - i) | i <- [max 0 (d - cols + 1)..min d (rowsCount - 1)]]
                  | d <- [0 .. rowsCount + cols - 2]]
  where
    rowsCount = length rows
    cols = maximum (map length rows)

diagonal' :: [String] -> [String]
diagonal' rows = [ [rows !! i !! (i - d) | i <- [max d 0 .. min (d + cols - 1) (rowsCount - 1)]]
                  | d <- [1 - cols .. rowsCount - 1]]
  where
    rowsCount = length rows
    cols = maximum (map length rows)

parsePuzzle :: String -> Int
parsePuzzle "" = 0
parsePuzzle a = case genericParse a of
  Left _          -> parsePuzzle (tail a)
  Right (p, "")   -> p
  Right (p, rest) -> p + parsePuzzle rest

genericParse :: String -> Either ParserErr (Int, String)
genericParse a = case result of
  Left s        -> Left s
  Right (p, bs) -> Right (p, bs)
  where
    result = runParser xmasParser a

xmasParser :: Parser Int
xmasParser = do
  string "XMAS"
  return 1
