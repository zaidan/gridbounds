module GridBounds.Bounds
  ( Bounds
  , bound
  , createGrid
  , createCompressedGrid
  ) where

-- GridBox
import GridBox.Grid (Grid)
import qualified GridBox.Grid as G
import GridBox.Row (Row)
import GridBox.Coordinate (fromBox)
import GridBox.Box (Box)
import GridBox.Compress (CompressedGrid, compressRow)

-- GJK
import GJK.Support (polySupport)
import GJK.Collision (collision)

import Data.Maybe (fromMaybe)

-- | A list of (x, y) coordinates representing the bounds of an object
type Bounds = [(Double, Double)]

-- | Bound the given grid to the given list of bounds.
bound :: [Bounds] -> Grid -> Grid
bound bounds grid = 
  map (boundRow bounds) grid

-- | Bound the given row to the given list of bounds.
-- Remove boxes that are not in bound.
boundRow :: [Bounds] -> Row -> Row
boundRow list row  =
  filter (isInBoundsList list) row

-- | Check if any triangle is in bounds.
isInBoundsList :: [Bounds] -> Box -> Bool
isInBoundsList list box =
  any (isInBounds box) list

-- | Check if the given box is in bounds by performing a collision detection.
isInBounds :: Box -> Bounds -> Bool
isInBounds box bounds = 
  fromMaybe False $ collision 1 (fromBox box, polySupport) (bounds, polySupport)

-- | Create the bounded grid.
createGrid :: [Bounds] -> (Double, Double) -> Double -> Double -> Double -> Double -> [Box]
createGrid bounds size width height xOffset yOffset =
  concat . bound bounds $ G.createGrid size width height xOffset yOffset

-- | Create the bounded grid and return a compressed grid.
createCompressedGrid :: [Bounds] -> (Double, Double) -> Double -> Double -> Double -> Double -> CompressedGrid
createCompressedGrid bounds size width height xOffset yOffset =
  compressRow $ createGrid bounds size width height xOffset yOffset
