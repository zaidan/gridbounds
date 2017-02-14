{-| Triangulate
-}
module GridBounds.Triangulate
  ( createGrid
  , createCompressedGrid
  , tcreateGrid
  , tcreateCompressedGrid
  ) where

import GridBounds.Bounds (Bounds)
import qualified GridBounds.Bounds as B
import qualified GridBounds.Transform as T

-- GridBox
import GridBox.Box (Box)
import GridBox.Compress (CompressedGrid)

-- Earclipper
import Earclipper.EarClipping (toTriangle)

-- | Create the bounded grid.
createGrid :: [Bounds] -> (Double, Double) -> Double -> Double -> Double -> Double -> [Box]
createGrid =
  B.createGrid . triangulate

-- | Create the bounded grid and return a compressed grid.
createCompressedGrid :: [Bounds] -> (Double, Double) -> Double -> Double -> Double -> Double -> CompressedGrid
createCompressedGrid =
  B.createCompressedGrid . triangulate

-- | Triangulate and transform the bounds and create the bounded grid.
tcreateGrid :: [Bounds] -> (Double, Double) -> Double -> (Double, Double) -> Double -> Double -> Double -> Double -> [Box]
tcreateGrid =
  T.createGrid . triangulate

-- | Triangulate and transform the bounds, create the bounded grid and return a compressed grid.
tcreateCompressedGrid :: [Bounds] -> (Double, Double) -> Double -> (Double, Double) -> Double -> Double -> Double -> Double -> CompressedGrid
tcreateCompressedGrid =
  T.createCompressedGrid . triangulate

-- | Triangulate multiple polygons and return a concaternated list of triangles
triangulate :: [Bounds] -> [Bounds]
triangulate =
  concatMap toTriangle
