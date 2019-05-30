import Text.Printf

type Coe = (Integer, Double)
type Poly = [Coe]

toPoly :: String -> Poly
toPoly = go . snd . splitAt 1 . words
    where
        go (x : y : ts)
            | ts == []  = [(read x, read y)]
            | otherwise = [(read x, read y)] ++ go ts
        go otherwise = []

fromCoe :: Coe -> String
fromCoe (rank, coe) = show rank ++ " " ++ printf "%.1f" coe

fromPoly :: Poly -> String
fromPoly p = concat $ [(show . length) p] ++ map ( (" " ++) . fromCoe) p

polyAdd :: Poly -> Poly -> Poly
polyAdd x y
    | x == []   = y
    | y == []   = x
    | otherwise = coe ++ polyAdd x' y'
        where
            ([(srank, s)], xs) = splitAt 1 x
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
