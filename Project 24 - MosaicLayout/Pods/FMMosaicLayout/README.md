dsd# FMMosaicLayout

[![CI Status](http://img.shields.io/travis/JVillella/FMMosaicLayout.svg?style=flat)](https://travis-ci.org/JVillella/FMMosaicLayout)
[![Version](https://img.shields.io/cocoapods/v/FMMosaicLayout.svg?style=flat)](http://cocoadocs.org/docsets/FMMosaicLayout)
[![License](https://img.shields.io/cocoapods/l/FMMosaicLayout.svg?style=flat)](http://cocoadocs.org/docsets/FMMosaicLayout)
[![Platform](https://img.shields.io/cocoapods/p/FMMosaicLayout.svg?style=flat)](http://cocoadocs.org/docsets/FMMosaicLayout)

FMMosaicLayout is a mosiac collection view layout. There are a great number of media-based iOS applications that use `UICollectionViewFlowLayout` without any modifications. This lends itself to boring presentation, and unengaging interaction. FMMosaicLayout is a step in the right direction. Simply add this pod to your project, set your preferences and it will layout out your collection view cells in pretty mosaics. The algorithm behind this got its inspiration from this [blog post](http://blog.vjeux.com/2012/image/image-layout-algorithm-facebook.html).

![Portrait Screenshot](http://fmitech.github.io/FMMosaicLayout/Screenshots/portrait-3.png)
![Animated GIF](https://fmitech.github.io/FMMosaicLayout/Screenshots/fmmosaiclayout.gif)

## Usage

FMMosaicLayout is very easy to use. Below is all you need to get going.

    - (void)viewDidLoad {
        ...
        
        FMMosaicLayout *mosaicLayout = [[FMMosaicLayout alloc] init];
        self.collectionView.collectionViewLayout = mosaicLayout;
        
        ...
    }
    
    #pragma mark <FMMosaicLayoutDelegate>
    
    - (NSInteger)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout
        numberOfColumnsInSection:(NSInteger)section {
        
        return 2; // Or any number of your choosing.
    }

It's also possible to set the layout via Interface Builder. To see a complete example implementation. Clone the repo, and run `pod install` from the Example directory. Then open up `Example/FMMosaicLayout.xcworkspace`.

## Customization

In addition to the required protocol method `collectionView:layout:numberOfColumnsInSection:`, there are several optional methods you can implement from `FMMosaicLayoutDelegate`. You can see them in action in the example project.

##### Mosaic Cell Size

    - (FMMosaicCellSize)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout
            mosaicCellSizeForItemAtIndexPath:(NSIndexPath *)indexPath;
    
This allows you to specify when you want to place a large or small mosaic cell.
    
##### Section Insets    
    
    - (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout
            insetForSectionAtIndex:(NSInteger)section;
            
Here you can specify a custom `UIEdgeInsets` for each section.

##### Interitem Spacing

    - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout
            interitemSpacingForSectionAtIndex:(NSInteger)section;

Here you can specify the spacing between cells.

##### Header and Footer Support

Below are the optional methods you can make use of to customize your headers and footers. The first methods are to set the height of your header/footers.

    - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout
     heightForHeaderInSection:(NSInteger)section;

    - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout
     heightForFooterInSection:(NSInteger)section;

If you want your header and/or to overlay your mosaic cells implement the following methods below in your delegate and have them return `YES`. The default is `NO`.

    - (BOOL)headerShouldOverlayContentInCollectionView:(UICollectionView *)collectionView
                                                layout:(FMMosaicLayout *)collectionViewLayout;

    - (BOOL)footerShouldOverlayContentInCollectionView:(UICollectionView *)collectionView
                                                layout:(FMMosaicLayout *)collectionViewLayout;

## Installation

FMMosaicLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "FMMosaicLayout"

## License

FMMosaicLayout is available under the MIT license. See the LICENSE file for more info.
