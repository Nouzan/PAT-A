addCommaEveryThree :: String -> String
addCommaEveryThree = fst . go ""
    where go s t
           | t == ""   = (s, t)
           | s == ""   = go u t'
           | otherwise = go (s ++ "," ++ u) t'
           where (u, t') = splitAt 3 t

formatInteger :: Integer -> String
formatInteger x
    | x < 0     = ("-" ++) . formatPositive . negate $ x
    | otherwise = formatPositive $ x
    where formatPositive = reverse . addCommaEveryThree . reverse . show

main :: IO ()
main = do interact $ unlines . map (formatInteger . sum . map read . words) . lines
