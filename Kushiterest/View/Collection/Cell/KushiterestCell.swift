//
//  KushiterestCell.swift
//  Kushiterest
//
//  Created by Kentaro on 2016/11/19.
//  Copyright © 2016年 Kentaro. All rights reserved.
//

import UIKit

final class KushiterestCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var photo: Photo?  {
        didSet {
            if let photo = photo {
                imageView.image = UIImage(named: photo.image)
                captionLabel.text = photo.caption
                commentLabel.text = photo.comment
            }
        }
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        captionLabel.text = nil
        commentLabel.text = nil
    }
    
    // 画像の高さを更新する
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        if let attributes = layoutAttributes as? KushiterestLayoutAttributes {
            imageViewHeightLayoutConstraint.constant = attributes.photoHeight
        }
    }
}

extension KushiterestCell: ImageCollectionViewCellType {}
