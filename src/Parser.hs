-- Parser.hs
module Parser where

import Text.Parsec
import Text.Parsec.String (Parser)
import Text.Parsec.Expr
import Data.Functor.Identity (Identity) --Unsure what its purpue is in table
import Types

whiteSpace :: Parser()
whiteSpace = skipMany space

-- <* throws away whiteSpace
lexeme :: Parser a -> Parser a
lexeme p = p<* whiteSpace

-- . is haskell for function composition
symbol :: String -> Parser String
symbol = lexeme . string

parenthesis :: Parser a -> Parser a
parenthesis p = symbol "(" *> p <* symbol ")"

getAtom :: Parser Proposition
getAtom = lexeme $ do
  char <- letter
  return (Atom [char])

getImplies :: Parser Proposition
getImplies = do
  p <- getAtom
  string "->"
  q <- getAtom
  return (p:->q)

table :: OperatorTable String () Identity Proposition
table =
  [ [Infix (symbol "->" >> return (:->)) AssocRight] ]

term :: Parser Proposition
term =
  getAtom
  <|> parenthesis expression

expression :: Parser Proposition
expression = buildExpressionParser table term

parseString :: String -> Either ParseError Proposition
parseString = parse (whiteSpace *> expression <* eof) ""
