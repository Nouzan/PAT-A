import Text.Printf

type Coe = (Integer, Double)
type Poly = [Coe]

toPoly :: String -> Poly
toPoly = go [] . snd . splitAt 1 . words
    where go s (x : y : ts)
            | ts == []  = s ++ [(read x, read y)]
            | otherwise = go (s ++ [(read x, read y)]) ts

fromCoe :: Coe -> String
fromCoe (rank, coe) = show rank ++ " " ++ printf "%.1f" coe

fromPoly :: Poly -> String
fromPoly p = concat $ [(show . length) p] ++ map ( (" " ++) . fromCoe) p

polyAdd :: Poly -> Poly -> Poly
polyAdd x y = go [] x y
    where go ans x y
            | x == []   = ans ++ y
            | y == []   = ans ++ x
            | otherwise = go (ans ++ coe) x' y'
                where   ([(srank, s)], xs) = splitAt 1 x
                        ([(trank, t)], ys) = splitAt 1 y
                        (coe, x', y')
                            | srank == trank = if s + t == 0 then ([], xs, ys) else ([(srank, s + t)], xs, ys)
                            | srank > trank  = ([(srank, s)], xs, y)
                            | otherwise      = ([(trank, t)], x, ys)

polySum :: [Poly] -> Poly
polySum [] = []
polySum (x : xs) = polyAdd x (polySum xs)

main :: IO ()
main = do interact $ printf "%s\n" . fromPoly . polySum . map(toPoly) . lines
