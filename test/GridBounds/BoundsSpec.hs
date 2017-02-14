module GridBounds.BoundsSpec where

import GridBounds.Bounds(createCompressedGrid)
import GridBox.Compress (CompressedGrid)

import GridBounds.Polygon

import Test.Hspec

outergrid :: CompressedGrid
outergrid = createCompressedGrid [polygon] (1.0, 1.0) 1.0 1.0 0 0

innergrid :: CompressedGrid
innergrid = createCompressedGrid [polygon] (50.0, 50.0) 1000.0 1000.0 0 0

expected :: CompressedGrid
expected =
  [
    (0,[(0,4)]),
    (1,[(0,4)]),
    (2,[(0,4)]),
    (3,[(0,5)]),
    (4,[(0,4)]),
    (5,[(0,4)]),
    (6,[(0,4)]),
    (7,[(0,4)]),
    (8,[(1,2)]),
    (9,[(1,2)])
  ]

spec :: Spec
spec =
  describe "createCompressedGrid" $ do
    it "should not find bounding boxes" $
      outergrid `shouldBe` []
    it "should find bounding boxes" $
      innergrid `shouldBe` expected
