{-# LANGUAGE PatternGuards, OverloadedStrings #-}

module Hajure.AST (listify) where

import Hajure.Data

-- $setup
-- >>> :set -XOverloadedStrings 

-- |
-- prop> listify s == (listify . listify) (s :: Element)
-- >>> let n  = Nested (SExpr [Ident "list", Num 3, Num 4])
-- >>> let n' = listify n
-- >>> listify n == n'
-- True
-- >>> print n'
-- List [Num 3.0,Num 4.0]

class Listifiable a where
  listify :: a -> Element

instance Listifiable Element where
  listify (Nested s) = listify s
  listify (List xs)  = List (map listify xs)
  listify e          = e

instance Listifiable SExpr where
  listify (SExpr xs'@(x:xs))
    | Ident e <- x
    , e == "list"  = List (map listify xs)
    | otherwise    = Nested . SExpr . map listify $ xs'
  listify s        = Nested s

