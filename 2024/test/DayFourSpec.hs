module DayFourSpec where

import           DayFour.A  (countXmas)
import           DayFour.B  (countXmas')
import           System.IO  (IOMode (ReadMode), hGetContents, withFile)
import           Test.Hspec

spec :: Spec
spec = do
  describe "Day 4.a" $ do
    it "solves the example" $ do
      withFile "fixtures/Day_4/a/example.txt" ReadMode $ \h -> do
        d <- hGetContents h
        countXmas d `shouldBe` 18
    it "solves the input" $ do
      withFile "fixtures/Day_4/a/input.txt" ReadMode $ \h -> do
        d <- hGetContents h
        countXmas d `shouldBe` 2599

  describe "Day 4.b" $ do
    it "solves the example" $ do
      withFile "fixtures/Day_4/b/example.txt" ReadMode $ \h -> do
        d <- hGetContents h
        countXmas' d `shouldBe` 9
  it "solves the input" $ do
      withFile "fixtures/Day_4/b/input.txt" ReadMode $ \h -> do
        d <- hGetContents h
        countXmas' d `shouldBe` 1948
