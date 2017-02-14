{-| Transform
-}
module GridBounds.Transform
  ( transform
  , transformList
  , createGrid
  , createCompressedGrid
  ) where

import GridBounds.Bounds (Bounds)
import qualified GridBounds.Bounds as B

-- GridBox
import qualified GridBox.Coordinate as Coordinate
import GridBox.Box (Box)
import GridBox.Compress (CompressedGrid, compressRow)

-- | Transform bounds to position (x, y) with given scale.
transform :: (Double, Double) -> Double -> Bounds ->  Bounds
transform position scale bounds=
  map (Coordinate.transform position scale) bounds

-- | Transform triangles to position (x, y) with given scale.
transformList :: [Bounds] -> (Double, Double) -> Double -> [Bounds]
transformList bounds position scale  =
  map (transform position scale) bounds

-- | Transforms the bounds and create the bounded grid.
createGrid :: [Bounds] -> (Double, Double) -> Double -> (Double, Double) -> Double -> Double -> Double -> Double -> [Box]
createGrid bounds position scale =
  B.createGrid (transformList bounds position scale)

-- | Transforms the bounds, create the bounded grid and return a compressed grid.
createCompressedGrid :: [Bounds] -> (Double, Double) -> Double -> (Double, Double) -> Double -> Double -> Double -> Double -> CompressedGrid
createCompressedGrid bounds position scale size width height xOffset yOffset =
  compressRow $ createGrid bounds position scale size width height xOffset yOffset
