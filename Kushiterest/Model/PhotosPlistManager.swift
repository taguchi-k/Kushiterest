//
//  PhotosPlistManager.swift
//  Kushiterest
//
//  Created by Kentaro on 2016/11/19.
//  Copyright © 2016年 Kentaro. All rights reserved.
//

import Foundation

final class PhotosPlistManager: PlistConvertible {
    
    typealias PlistModel = [Photo]
    
    static let fileName = "photos"
    static let key = "photos"
    
    class func load() -> PlistModel {
        
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "plist"),
            let dict = NSDictionary(contentsOf: url),
            let array = dict[key] as? [AnyObject] else { fatalError() }
        
        return array.map { object -> Photo in
            guard
                let caption = object["caption"] as? String,
                let comment = object["comment"] as? String,
                let image = object["image"] as? String else { fatalError() }
            
            return Photo(caption: caption, comment: comment, image: image)
        }
    }
}
