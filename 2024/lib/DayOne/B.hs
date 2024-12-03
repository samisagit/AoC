module DayOne.B where

import           Data.List

similarity :: String -> Int
similarity = sum
             .(\(xs, ys) -> map (\x -> x * length (filter (== x) ys)) xs)
             . (\xs -> (head xs, last xs))
             . transpose
             . map (map read . words)
             . lines
