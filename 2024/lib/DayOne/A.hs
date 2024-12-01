module DayOne.A where

import           Data.List
import           Prelude

totalDistance :: String -> Int
totalDistance = sum
                . map abs
                . map (\xs -> head xs - last xs)
                . transpose
                . map sort
                . transpose
                . map (map read)
                . map words
                . lines
