primes :: [Integer]
primes = 2 : sieve primes [3..] 
    where 
    sieve (p:pt) xs = let (h,t) = span (< p*p) xs 
                      in h ++ sieve pt [x | x <- t, rem x p > 0]

isPrime :: Integer -> (Bool, Integer)
isPrime n = go n primes
        where
            go n (p:ps)
                | p * p > n = (True, 1)
                | otherwise = if rem n p == 0 then (False, p) else go n ps

main :: IO ()
main = do interact $ unlines . map(show . isPrime . read) .  lines