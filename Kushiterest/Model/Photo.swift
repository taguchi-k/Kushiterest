//
//  Photo.swift
//  Kushiterest
//
//  Created by Kentaro on 2016/11/19.
//  Copyright © 2016年 Kentaro. All rights reserved.
//

import UIKit

struct Photo {
    
    static let padding = CGFloat(4)
    static let captionFontSize = CGFloat(13)
    static let commentFontSize = CGFloat(11)
    
    let caption: String
    let comment: String
    let image: String
    
    // キャプションの高さを取得する
    func heightForCaption(font: UIFont, width: CGFloat) -> CGFloat {
        
        let rect = NSString(string: caption).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font], context: nil)
        
        return ceil(rect.height)
    }
    
    // コメントの高さを取得する
    func heightForComment(font: UIFont, width: CGFloat) -> CGFloat {
        
        let rect = NSString(string: comment).boundingRect(
            with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
            options: .usesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font], context: nil)
        
        return ceil(rect.height)
    }
    
}
