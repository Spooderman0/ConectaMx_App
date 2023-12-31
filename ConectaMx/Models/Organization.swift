// Organization.swift
import Foundation
import SwiftData


struct Organization: Identifiable {
    var id: String
    var name: String
    var alias: String
    var location: Location
    var contact: Contact
    var serviceHours: String
    var website: String
    var socialMedia: SocialMedia
    var missionStatement: String
    var logo: String
    var tags: [String]
    var RFC: String
    var postId: [String]
    var followers: [String] // Added followers array
    var password: String // Added password
    
    init(
        id: String,
        name: String,
        alias: String,
        location: Location,
        contact: Contact,
        serviceHours: String,
        website: String,
        socialMedia: SocialMedia,
        missionStatement: String,
        logo: String,
        tags: [String],
        RFC: String,
        postId: [String],
        followers: [String],
        password: String
    ) {
        self.id = id
        self.name = name
        self.alias = alias
        self.location = location
        self.contact = contact
        self.serviceHours = serviceHours
        self.website = website
        self.socialMedia = socialMedia
        self.missionStatement = missionStatement
        self.logo = logo
        self.tags = tags
        self.RFC = RFC
        self.postId = postId
        self.followers = followers
        self.password = password
    }
}

struct SocialMedia {
    var facebook: String
    var twitter: String
    var instagram: String
    var linkedIn: String
    var youtube: String // Added youtube
    var tiktok: String // Added tiktok
    var whatsapp: String // Added whatsapp
    
    init(facebook: String, twitter: String, instagram: String, linkedIn: String, youtube: String, tiktok: String, whatsapp: String) {
        self.facebook = facebook
        self.twitter = twitter
        self.instagram = instagram
        self.linkedIn = linkedIn
        self.youtube = youtube
        self.tiktok = tiktok
        self.whatsapp = whatsapp
    }
}

// Remaining structs (Location, Contact) can stay as they are.


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

struct Logo {
    var url: String

    init(url: String) {
        self.url = url
    }
}

struct Contact {
    var email: String
    var first_phone: String
    var second_phone: String

    init(email: String, first_phone: String, second_phone: String) {
        self.email = email
        self.first_phone = first_phone
        self.second_phone = second_phone
    }
}

