module DayOneSpec (spec) where

import           DayOne.A   (totalDistance)
import           DayOne.B   (similarity)
import           System.IO  (IOMode (ReadMode), hGetContents, withFile)
import           Test.Hspec

spec :: Spec
spec = do
  describe "Day 1.a" $ do
    it "solves the example" $ do
      withFile "fixtures/Day_1/a/example.txt" ReadMode $ \h -> do
        d <- hGetContents h
        totalDistance d `shouldBe` 11
    it "solves the input" $ do
      withFile "fixtures/Day_1/a/input.txt" ReadMode $ \h -> do
        d <- hGetContents h
        totalDistance d `shouldBe` 1189304

  describe "Day 1.b" $ do
    it "solves the example" $ do
      withFile "fixtures/Day_1/b/example.txt" ReadMode $ \h -> do
        d <- hGetContents h
        similarity d `shouldBe` 31
    it "solves the input" $ do
      withFile "fixtures/Day_1/b/input.txt" ReadMode $ \h -> do
        d <- hGetContents h
        similarity d `shouldBe` 24349736

