import System.Environment        (getArgs,getProgName)
import Text.Regex                (mkRegex)
import Text.Regex.Base.RegexLike (match)

main :: IO ()
main = do
  args <- getArgs
  name <- getProgName
  if   printHelpParamPassed args
  then printHelp name
  else 
    let (lower,upper) = getRange $ getDigits args
    in  print $ maximum [ x*y | x <- [lower..upper], y <- [lower..upper], isPalindrome (x*y)]

getDigits :: [String] -> Int
getDigits args =
  if   not  $ null args
  then read $ head args 
  else 3 --default

printHelpParamPassed :: [String] -> Bool
printHelpParamPassed =
  any (match $ mkRegex "-+[hH](elp)?")

printHelp :: String -> IO ()
printHelp name =
  putStrLn ("\n"
         ++ "  Usage: "++name++" <digits>\n"
         ++ "  Calculates the largest palindrome which is\n"
         ++ "  the product of two <digits> digit number\n"
         ++ "    <digits>  :: Int (3)\n")

{-!-}

isPalindrome :: Int -> Bool
isPalindrome n = reverse (show n) == show n

getRange :: Int -> (Int,Int)
getRange digits =  ( 10^(digits-1), (10^digits)-1 )

