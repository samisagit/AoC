module DayFour.B where

import           Data.List

countXmas' :: String -> Int
countXmas' = (\cs -> checkCoords cs cs)
             . coordsForGrid

checkCoords :: [((Int, Int), Char)] -> [((Int, Int), Char)] -> Int
checkCoords [] _                   = 0
checkCoords (((y,x), 'A'):xs) grid = if checkForXmas grid (y, x) then 1 + checkCoords xs grid else checkCoords xs grid
checkCoords (_:xs) grid            = checkCoords xs grid

checkForXmas :: [((Int, Int), Char)] -> (Int, Int) -> Bool
checkForXmas grid (y,x) = sort [lookup (y-1,x-1) grid, lookup (y+1,x+1) grid ] == [Just 'M', Just 'S']
                         && sort [lookup (y+1,x-1) grid, lookup (y-1,x+1) grid ] == [Just 'M', Just 'S']

coordsForGrid :: String -> [((Int, Int), Char)]
coordsForGrid grid = let rows = lines grid
                         cols = maximum (map length rows)
                         rowsCount = length rows
                         result = [(x, y) | x <- [0..rowsCount - 1], y <- [0..cols - 1]]
                     in zip result (concat . lines $ grid)

