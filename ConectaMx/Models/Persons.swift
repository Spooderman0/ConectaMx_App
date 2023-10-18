// Person.swift
import Foundation

struct Person: Identifiable {
    var id: String
    var name: String
    var phone: String
    var email: String
    var password: String
    var interestedTags: [String]
    var favorites: [String]

    init(id: String, name: String, phone: String, email: String, password: String, interestedTags: [String], favorites: [String]) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.password = password
        self.interestedTags = interestedTags
        self.favorites = favorites
    }
}
