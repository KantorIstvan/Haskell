module Hazi1 where

--1. feladat

intExpr1 :: Int
intExpr1 = 2 + 3

intExpr2 :: Int
intExpr2 = 2 * 3

intExpr3 :: Int
intExpr3 = 2 + 3 * 4

charExpr1 :: Char
charExpr1 = 'a'

charExpr2 :: Char
charExpr2 = 'b'

charExpr3 :: Char
charExpr3 = 'c'

boolExpr1 :: Bool
boolExpr1 = True

boolExpr2 :: Bool
boolExpr2 = False

boolExpr3 :: Bool
boolExpr3 = True && False

--2. feladat

inc :: Integer -> Integer
inc x = x + 1

triple :: Integer -> Integer
triple x = x * 3

--3. feladat

thirteen1 :: Integer
thirteen1 = inc(inc(inc(inc(triple(triple(inc 0)))))) 

thirteen2 :: Integer
thirteen2 = inc(inc(inc(inc(inc(inc(inc(inc(inc(inc(inc(inc(inc 0))))))))))))

thirteen3 :: Integer
thirteen3 = inc(triple(inc(inc(inc(inc 0)))))

--4. feladat

cmpRem5Rem7 :: Int -> Bool
cmpRem5Rem7 x = mod x 5 > mod x 7