//
//  PlistConvertible.swift
//  Kushiterest
//
//  Created by Kentaro on 2016/11/19.
//  Copyright © 2016年 Kentaro. All rights reserved.
//

import Foundation

protocol PlistConvertible {
    associatedtype PlistModel: Collection
    static var fileName: String { get }
    static func load() -> PlistModel
}
