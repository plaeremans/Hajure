{-# LANGUAGE PatternGuards, OverloadedStrings #-}

module Hajure.AST (listify) where

import Hajure.Data

listify :: TextElem -> TextElem
listify (Nested (SExpr xs'@(x:xs)))
  | Ident e <- x
  , e == "list"   = List (map listify xs)
  | otherwise     = Nested . SExpr $ map listify xs'
listify (List xs) = List (map listify xs)
listify e         = e

