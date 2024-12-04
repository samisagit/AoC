module DayThreeSpec where

import           DayThree.A (parseMemory)
import           DayThree.B (parseGuardedMemory)
import           System.IO  (IOMode (ReadMode), hGetContents, withFile)
import           Test.Hspec

spec :: Spec
spec = do
  describe "Day 3.a" $ do
    it "solves the example" $ do
      withFile "fixtures/Day_3/a/example.txt" ReadMode $ \h -> do
        d <- hGetContents h
        parseMemory d `shouldBe` 161
    it "solves the input" $ do
      withFile "fixtures/Day_3/a/input.txt" ReadMode $ \h -> do
        d <- hGetContents h
        parseMemory d `shouldBe` 175015740

  describe "Day 3.b" $ do
    it "solves the example" $ do
      withFile "fixtures/Day_3/b/example.txt" ReadMode $ \h -> do
        d <- hGetContents h
        parseGuardedMemory d `shouldBe` 48
    it "solves the input" $ do
      withFile "fixtures/Day_3/b/input.txt" ReadMode $ \h -> do
        d <- hGetContents h
        parseGuardedMemory d `shouldBe` 112272912
