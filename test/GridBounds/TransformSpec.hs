module GridBounds.TransformSpec where

import GridBounds.Transform(createCompressedGrid)
import GridBox.Compress (CompressedGrid)

import GridBounds.Polygon

import Test.Hspec

transformedgrid :: CompressedGrid
transformedgrid = createCompressedGrid [polygon] (500.0, 500.0) 0.1 (50.0, 50.0) 1000.0 1000.0 0 0

outertransformedgrid :: CompressedGrid
outertransformedgrid = createCompressedGrid [polygon] (1049.0, 1049.0) 0.1 (50.0, 50.0) 1000.0 1000.0 0 0

spec :: Spec
spec =
  describe "createCompressedGrid" $ do
    it "should not find bounding boxes" $
      outertransformedgrid `shouldBe` []
    it "should find bounding boxes" $
      transformedgrid `shouldBe` [(10,[(10,1)])]
