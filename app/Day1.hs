module Day1(day1) where

import Data.Char (isDigit)
import Data.List (isPrefixOf, find)
import Data.Bifoldable (bifoldMap)
import Data.Maybe(maybeToList)
import System.Directory

ints :: [(String, Char)]
ints = [
  ("1", '1'),
  ("one", '1'),
  ("2", '2'),
  ("two", '2'),
  ("3", '3'),
  ("three", '3'),
  ("4", '4'),
  ("four", '4'),
  ("5", '5'),
  ("five", '5'),
  ("6", '6'),
  ("six", '6'),
  ("7", '7'),
  ("seven", '7'),
  ("8", '8'),
  ("eight", '8'),
  ("9", '9'),
  ("nine", '9')]

detectInt :: String -> Maybe Char
detectInt str =
  let
    matchStr s (x, _) = x `isPrefixOf` s
    match = find (matchStr str) ints
  in
    snd <$> match

strToInt :: String -> [Char]
strToInt [] = []
strToInt str@(_:xs) = (maybeToList $ detectInt str) ++ strToInt xs

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

solution2 :: String -> Either String Int
solution2 input = sum <$> (traverse (lineToInt . strToInt) $ lines input)

day1 :: IO ()
day1 = do
  home <- getHomeDirectory
  input <- readFile $ home ++ "/.local/adventofcode2023/day1.txt"
  let output = solution input
  putStrLn $ bifoldMap id show $ output
  let output2 = solution2 input
  putStrLn $ bifoldMap id show $ output2
