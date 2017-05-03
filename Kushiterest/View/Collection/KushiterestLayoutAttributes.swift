//
//  KushiterestLayoutAttributes.swift
//  Kushiterest
//
//  Created by Kentaro on 2016/11/19.
//  Copyright © 2016年 Kentaro. All rights reserved.
//

import UIKit

final class KushiterestLayoutAttributes: UICollectionViewLayoutAttributes {

    var photoHeight = CGFloat(0.0)
    
    override func copy(with zone: NSZone?) -> Any {
        
        guard let copy = super.copy(with: zone) as? KushiterestLayoutAttributes else { fatalError() }
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if let attributes = object as? KushiterestLayoutAttributes {

            if attributes.photoHeight == photoHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}
