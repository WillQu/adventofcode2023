module Day1(day1) where

import Data.Char (isDigit)
import Data.Bifoldable (bifoldMap)
import System.Directory

lineToInt :: String -> Either String Int
lineToInt str =
  let
    figures = filter isDigit str
    firstChar line = case line of
      x:_ -> Right x
      _ -> Left $ "No char in line? " ++ str
  in
    read <$> traverse firstChar [figures, reverse figures]

solution :: String -> Either String Int
solution input = sum <$> (traverse lineToInt $ lines input)

day1 :: IO ()
day1 = do
  home <- getHomeDirectory
  input <- readFile $ home ++ "/.local/adventofcode2023/day1.txt"
  let output = solution input
  putStrLn $ bifoldMap id show $ output
