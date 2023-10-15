// Tag.swift
import Foundation
import SwiftData

struct Tag: Identifiable  {
    var id: String
    var tags: [String]
//    var description: String
    
    init(id: String, tags: [String]){
        self.id = id
        self.tags = tags
    }
}

