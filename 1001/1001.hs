addCommaEveryThree :: String -> String
addCommaEveryThree "" = ""
addCommaEveryThree s  = t ++ comma s' ++ addCommaEveryThree s'
    where
        (t, s') = splitAt 3 s
        comma "" = ""
        comma _  = ","

formatInteger :: Integer -> String
formatInteger x
    | x < 0     = ("-" ++) . formatPositive . negate $ x
    | otherwise = formatPositive $ x
    where formatPositive = reverse . addCommaEveryThree . reverse . show

main :: IO ()
main = do interact $ unlines . map (formatInteger . sum . map read . words) . lines
