module Main where

import Happstack.Lite
import TestApp

main :: IO()
main = serve Nothing testApp
