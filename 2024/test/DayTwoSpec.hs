module DayTwoSpec (spec) where

import           DayTwo.A   (countSafeReports)
import           DayTwo.B   (countSafeReportsTolerant)
import           System.IO  (IOMode (ReadMode), hGetContents, withFile)
import           Test.Hspec

spec :: Spec
spec = do
  describe "Day 2.a" $ do
    it "solves the example" $ do
      withFile "fixtures/Day_2/a/example.txt" ReadMode $ \h -> do
        d <- hGetContents h
        countSafeReports d `shouldBe` 2
    it "solves the input" $ do
      withFile "fixtures/Day_2/a/input.txt" ReadMode $ \h -> do
        d <- hGetContents h
        countSafeReports d `shouldBe` 472

  describe "Day 2.b" $ do
    it "solves the example" $ do
      withFile "fixtures/Day_2/b/example.txt" ReadMode $ \h -> do
        d <- hGetContents h
        countSafeReportsTolerant d `shouldBe` 4
    it "solves the input" $ do
      withFile "fixtures/Day_2/b/input.txt" ReadMode $ \h -> do
        d <- hGetContents h
        countSafeReportsTolerant d `shouldBe` 520

