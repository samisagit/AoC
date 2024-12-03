module DayTwo.B where

countSafeReportsTolerant :: String -> Int
countSafeReportsTolerant = length . filter isSafe . lines
  where
        variations xs = [take i xs ++ drop (i + 1) xs | i <- [0..length xs - 1]] ++ [xs]
        isSafe = any ((\ xs -> all (`elem` ([1, 2, 3]::[Int])) xs || all (`elem` ([-1, -2, -3]::[Int])) xs )
                       . map (uncurry (-))
                       . (\xs -> zip xs (tail xs)))
                 . variations
                 . map read
                 . words

