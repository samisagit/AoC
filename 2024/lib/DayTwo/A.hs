module DayTwo.A where

countSafeReports :: String -> Int
countSafeReports = length . filter isSafe . lines
  where isSafe = (\ xs -> all (`elem` ([1, 2, 3]::[Int])) xs || all (`elem` ([-1, -2, -3]::[Int])) xs )
                 . map (uncurry (-))
                 .(\xs -> zip xs (tail xs))
                 . map read
                 . words

