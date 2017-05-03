//
//  KushiterestLayout.swift
//  Kushiterest
//
//  Created by Kentaro on 2016/11/19.
//  Copyright © 2016年 Kentaro. All rights reserved.
//

import UIKit

final class KushiterestLayout: UICollectionViewLayout {
    
    var delegate: KushiterestLayoutDelegate?
    
    var numberOfColumns = 2
    var cellPadding = CGFloat(8.0)
    
    var cache = [KushiterestLayoutAttributes]()
    
    var contentHeight = CGFloat(0.0)
    var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    override class var layoutAttributesClass : AnyClass {
        return KushiterestLayoutAttributes.self
    }

    //MARK:- Layout LifeCycle
    /**
     1. レイアウトの事前計算を行う
     */
    override func prepare() {
        
        guard
            cache.isEmpty,
            let collectionView = collectionView,
            let delegate = delegate else { return }
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        let xOffset = (0 ..< numberOfColumns).map { CGFloat($0) * columnWidth }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            
            let width = columnWidth - cellPadding * 2
            let photoHeight = delegate.collectionView(collectionView,
                                                       heightForPhotoAtIndexPath: indexPath,
                                                       withWidth: width)
            let labelHeight = delegate.collectionView(collectionView,
                                                       heightForCaptionAndCommentAtIndexPath: indexPath,
                                                       withWidth: width)
            
            let height = cellPadding + photoHeight + labelHeight
            
            let frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = KushiterestLayoutAttributes(forCellWith: indexPath)
            attributes.photoHeight = photoHeight
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            if column >= numberOfColumns - 1 {
                column = 0
            } else {
                column += 1
            }
        }
    }
    
    /**
     2. コンテンツのサイズを返す
     */
    override var collectionViewContentSize : CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    /**
     3. 表示する要素のリストを返す
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }
}
