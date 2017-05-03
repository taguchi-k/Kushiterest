//
//  ImageTransitionProtocol.swift
//  Kushiterest
//
//  Created by Kentaro on 2016/11/19.
//  Copyright © 2016年 Kentaro. All rights reserved.
//

import UIKit

protocol ImageSourceTransitionType {
    var collectionView: UICollectionView! {get}
    var baseView: UIView! {get}
}

protocol ImageDistinationTransitionType {
    var imageView: UIImageView! {get}
    var baseView: UIView! {get}
}

protocol ImageCollectionViewCellType {
    var imageView: UIImageView! {get}
}
