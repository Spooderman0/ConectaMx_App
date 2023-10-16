// Post.swift
import Foundation

struct Post: Identifiable {
    var id: String
    var title: String
    var content: String
    var organizationId: String
    var createdAt: String
    var updatedAt: String
    
    init(id: String, title: String, content: String, organizationId: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.title = title
        self.content = content
        self.organizationId = organizationId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
