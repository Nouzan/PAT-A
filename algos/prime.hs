primes :: [Integer]
primes = 2 : sieve primes [3..] 
    where 
    sieve (p:pt) xs = let (h,t) = span (< p*p) xs 
                      in h ++ sieve pt [x | x <- t, rem x p > 0]

isPrime :: Integer -> Bool
isPrime p = elem p . (take . ceiling . sqrt . fromInteger) p $ primes

main :: IO ()
main = do interact $ unlines . map(show . isPrime . read) .  lines