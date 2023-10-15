// Organization.swift
import Foundation
import SwiftData

struct Organization: Identifiable {
    var id: String
    var name: String
    var location: Location
    var contact: Contact
    var serviceHours: String
    var socialMedia: SocialMedia
    var missionStatement: String
    var tags: [String]
    //var followers: [String]
    
    init(id: String, name: String, location: Location, contact: Contact, serviceHours: String, socialMedia: SocialMedia, missionStatement: String, tags: [String]){//}, followers: [String]) {
        self.id = id
        self.name = name
        self.location = location
        self.contact = contact
        self.serviceHours = serviceHours
        self.socialMedia = socialMedia
        self.missionStatement = missionStatement
        self.tags = tags
        //self.followers = followers
    }
}

struct Location {
    var address: String
    var city: String
    var state: String
    var country: String
    var zip: String
    
    init(address: String, city: String, state: String, country: String, zip: String) {
        self.address = address
        self.city = city
        self.state = state
        self.country = country
        self.zip = zip
    }
}

struct Contact {
    var email: String
    var phone: String
    
    init(email: String, phone: String) {
        self.email = email
        self.phone = phone
    }
}

struct SocialMedia {
    var facebook: String
    var twitter: String
    var instagram: String
    var linkedIn: String
    
    init(facebook: String, twitter: String, instagram: String, linkedIn: String) {
        self.facebook = facebook
        self.twitter = twitter
        self.instagram = instagram
        self.linkedIn = linkedIn
    }
}
