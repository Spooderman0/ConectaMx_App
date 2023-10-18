
// OrganizationModel.swift
import SwiftUI
import SwiftyJSON
import Alamofire

@Observable
class OrganizationModel {
    var organizations = [Organization]()
    var tagOrgs = [Organization]()
    //var LogedInOrg = Organization()
    //@Published var currentOrganization: Organization?
    
    init() {
        
    }
    let baseURL = "http://10.14.255.172:5000"
    
    func fetchOrganizations() {
        organizations.removeAll()
        
        let url = "\(baseURL)/get_organizations"
        
        AF.request(url, method: .get, encoding: URLEncoding.default).responseData { [self] data in
            if let error = data.error {
                print("Error de conexion: \(error)")
            } else {
                let json = try! JSON(data: data.data!)
                
                for organization in json {
                    let location = Location(
                    address: organization.1["location"]["address"].stringValue,
                    city: organization.1["location"]["city"].stringValue,
                    state: organization.1["location"]["state"].stringValue,
                    country: organization.1["location"]["country"].stringValue,
                    zip: organization.1["location"]["zip"].stringValue
                )
                
                    let contact = Contact(
                    email: organization.1["contact"]["email"].stringValue,
                    first_phone: organization.1["contact"]["first_phone"].stringValue,
                    second_phone: organization.1["contact"]["second_phone"].stringValue
                )
                
                    let socialMedia = SocialMedia(
                        facebook: organization.1["socialMedia"]["facebook"].stringValue,
                        twitter: organization.1["socialMedia"]["twitter"].stringValue,
                        instagram: organization.1["socialMedia"]["instagram"].stringValue,
                        linkedIn: organization.1["socialMedia"]["linkedIn"].stringValue,
                        youtube: organization.1["socialMedia"]["youtube"].stringValue, // Added youtube
                        tiktok: organization.1["socialMedia"]["tiktok"].stringValue, // Added tiktok
                        whatsapp: organization.1["socialMedia"]["whatsapp"].stringValue // Added whatsapp
                    )
                
                    let newOrganization = Organization(
                    id: organization.1["_id"]["$oid"].stringValue,
                    name: organization.1["name"].stringValue,
                    alias: organization.1["alias"].stringValue,
                    location: location,
                    contact: contact,
                    serviceHours: organization.1["serviceHours"].stringValue,
                    website: organization.1["website"].stringValue,
                    socialMedia: socialMedia,
                    missionStatement: organization.1["missionStatement"].stringValue,
                    logo: organization.1["logo"].stringValue,
                    tags: (organization.1["tags"].arrayObject as? [String]) ?? [],
                    RFC: organization.1["RFC"].stringValue,
                    postId: (organization.1["postId"].arrayObject as? [String]) ?? [],
                    followers: (organization.1["followers"].arrayObject as? [String]) ?? [],
                    password: organization.1["password"].stringValue
                )
                //print(newOrganization)
                organizations.append(newOrganization)
            }
//                let orgModel = OrganizationModel()
//                //orgModel.fetchOrganizations()
//                print("Printing orgs in model")
//                print(organizations.count)
//                for org in organizations {
//                    print("org name: ")
//                    print(org.id)
//                }
            }
        }
        
    }
    
    func printOrgs() {
//        let orgModel = OrganizationModel()
//        //orgModel.fetchOrganizations()
//        print("Printing orgs")
//        print(orgModel.organizations.count)
//        for org in orgModel.organizations {
//            print("1+")
//            print(org)
//        }
    }
    
    
    func postOrganization(organization: Organization, completion: @escaping (Bool) -> Void) {
        let urlString = "\(baseURL)/register_organization"
        
        // Convert Organization instance to a dictionary
        let parameters = organization.toDictionary()
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }

    func updateOrganization(organizationId: String, organization: Organization, completion: @escaping (Bool) -> Void) {
        let urlString = "\(baseURL)/update_organization/\(organizationId)"
        
        // Convert Organization instance to a dictionary
        let parameters = organization.toDictionary()
        
        AF.request(urlString, method: .put, parameters: parameters, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
    func updateOrganizationTags(organizationId: String, newTags: [String], completion: @escaping (Bool) -> Void) {
        let urlString = "\(baseURL)/update_organization/\(organizationId)"
        
        let parameters: [String: Any] = ["tags": newTags]
        
        AF.request(urlString, method: .put, parameters: parameters, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }

    
//    func fetchOrganization(rfc: String, password: String, completion: @escaping (Organization?, Error?) -> Void) {
//        let urlString = "\(baseURL)/get_organization?rfc=\(rfc)&password=\(password)"
//        
//        AF.request(urlString, method: .get, encoding: URLEncoding.default).responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    let json = try JSON(data: data)
    func fetchOrganization(rfc: String, password: String, completion: @escaping (Organization?, Error?) -> Void) {
        let urlString = "\(baseURL)/get_organization"
        
        let parameters: [String: Any] = [
            "rfc": rfc,
            "password": password
        ]
        
        AF.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSON(data: data)
                    
                    // Assuming the first organization is the one you want
                    guard let organizationData = json.array?.first else {
                        completion(nil, NSError(domain: "", code: 404, userInfo: ["message": "Organization not found"]))
                        return
                    }
                    
                    let location = Location(
                        address: json["location"]["address"].stringValue,
                        city: json["location"]["city"].stringValue,
                        state: json["location"]["state"].stringValue,
                        country: json["location"]["country"].stringValue,
                        zip: json["location"]["zip"].stringValue
                    )
                    
                    let contact = Contact(
                        email: json["contact"]["email"].stringValue,
                        first_phone: json["contact"]["first_phone"].stringValue,
                        second_phone: json["contact"]["second_phone"].stringValue
                    )
                    
                    let socialMedia = SocialMedia(
                        facebook: json["socialMedia"]["facebook"].stringValue,
                        twitter: json["socialMedia"]["twitter"].stringValue,
                        instagram: json["socialMedia"]["instagram"].stringValue,
                        linkedIn: json["socialMedia"]["linkedIn"].stringValue,
                        youtube: json["socialMedia"]["youtube"].stringValue, // Added youtube
                        tiktok: json["socialMedia"]["tiktok"].stringValue, // Added tiktok
                        whatsapp: json["socialMedia"]["whatsapp"].stringValue // Added whatsapp
                    )
                    
                    let fetchedOrganization = Organization(
                        id: json["_id"]["$oid"].stringValue,
                        name: json["name"].stringValue,
                        alias: json["alias"].stringValue,
                        location: location,
                        contact: contact,
                        serviceHours: json["serviceHours"].stringValue,
                        website: json["website"].stringValue,
                        socialMedia: socialMedia,
                        missionStatement: json["missionStatement"].stringValue,
                        logo: json["logo"].stringValue,
                        tags: (json["tags"].arrayObject as? [String]) ?? [],
                        RFC: json["RFC"].stringValue,
                        postId: (json["postId"].arrayObject as? [String]) ?? [],
                        followers: (json["followers"].arrayObject as? [String]) ?? [],
                        password: json["password"].stringValue
                    )
                    completion(fetchedOrganization, nil)
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    
    func loginOrganization(rfc: String, password: String, completion: @escaping (Organization?, Error?) -> Void) {
        let urlString = "\(baseURL)/login_organization"
        
        let parameters: [String: Any] = [
            "RFC": rfc,
            "password": password
        ]
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSON(data: data!)
                    
                    let location = Location(
                        address: json["organization_info"]["location"]["address"].stringValue,
                        city: json["organization_info"]["location"]["city"].stringValue,
                        state: json["organization_info"]["location"]["state"].stringValue,
                        country: json["organization_info"]["location"]["country"].stringValue,
                        zip: json["organization_info"]["location"]["zip"].stringValue
                    )
                    
                    let contact = Contact(
                        email: json["organization_info"]["contact"]["email"].stringValue,
                        first_phone: json["organization_info"]["contact"]["first_phone"].stringValue,
                        second_phone: json["organization_info"]["contact"]["second_phone"].stringValue
                    )
                    
                    let socialMedia = SocialMedia(
                        facebook: json["organization_info"]["socialMedia"]["facebook"].stringValue,
                        twitter: json["organization_info"]["socialMedia"]["twitter"].stringValue,
                        instagram: json["organization_info"]["socialMedia"]["instagram"].stringValue,
                        linkedIn: json["organization_info"]["socialMedia"]["linkedIn"].stringValue,
                        youtube: json["organization_info"]["socialMedia"]["youtube"].stringValue,
                        tiktok: json["organization_info"]["socialMedia"]["tiktok"].stringValue,
                        whatsapp: json["organization_info"]["socialMedia"]["whatsapp"].stringValue
                    )
                    
                    let loggedInOrganization = Organization(
                        id: json["organization_info"]["_id"]["$oid"].stringValue,
                        name: json["organization_info"]["name"].stringValue,
                        alias: json["organization_info"]["alias"].stringValue,
                        location: location,
                        contact: contact,
                        serviceHours: json["organization_info"]["serviceHours"].stringValue,
                        website: json["organization_info"]["website"].stringValue,
                        socialMedia: socialMedia,
                        missionStatement: json["organization_info"]["missionStatement"].stringValue,
                        logo: json["organization_info"]["logo"].stringValue,
                        tags: (json["organization_info"]["tags"].arrayObject as? [String]) ?? [],
                        RFC: json["organization_info"]["RFC"].stringValue,
                        postId: (json["organization_info"]["postId"].arrayObject as? [String]) ?? [],
                        followers: (json["organization_info"]["followers"].arrayObject as? [String]) ?? [],
                        password: json["organization_info"]["password"].stringValue
                    )
                    completion(loggedInOrganization, nil)
                } catch {
                    completion(nil, error)
                }
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    
    func fetchOrganizationsByTag(tag: String) {
        tagOrgs.removeAll()
        
        let url = "\(baseURL)/get_organizations_by_tags?tags=\(tag)"
        
        AF.request(url, method: .get, encoding: URLEncoding.default).responseData { [self] data in
            if let error = data.error {
                print("Error in fetching organizations by tag: \(error)")
            } else {
                let json = try! JSON(data: data.data!)
                
                for organization in json.arrayValue {
                    let location = Location(
                        address: organization["location"]["address"].stringValue,
                        city: organization["location"]["city"].stringValue,
                        state: organization["location"]["state"].stringValue,
                        country: organization["location"]["country"].stringValue,
                        zip: organization["location"]["zip"].stringValue
                    )
                    
                    let contact = Contact(
                        email: organization["contact"]["email"].stringValue,
                        first_phone: organization["contact"]["first_phone"].stringValue,
                        second_phone: organization["contact"]["second_phone"].stringValue
                    )
                    
                    let socialMedia = SocialMedia(
                        facebook: json["socialMedia"]["facebook"].stringValue,
                        twitter: json["socialMedia"]["twitter"].stringValue,
                        instagram: json["socialMedia"]["instagram"].stringValue,
                        linkedIn: json["socialMedia"]["linkedIn"].stringValue,
                        youtube: json["socialMedia"]["youtube"].stringValue, // Added youtube
                        tiktok: json["socialMedia"]["tiktok"].stringValue, // Added tiktok
                        whatsapp: json["socialMedia"]["whatsapp"].stringValue // Added whatsapp
                    )
                    
                    let newOrganization = Organization(
                        id: json["_id"]["$oid"].stringValue,
                        name: json["name"].stringValue,
                        alias: json["alias"].stringValue,
                        location: location,
                        contact: contact,
                        serviceHours: json["serviceHours"].stringValue,
                        website: json["website"].stringValue,
                        socialMedia: socialMedia,
                        missionStatement: json["missionStatement"].stringValue,
                        logo: json["logo"].stringValue,
                        tags: (json["tags"].arrayObject as? [String])!,
                        RFC: json["RFC"].stringValue,
                        postId: (json["postId"].arrayObject as? [String])!,
                        followers: (json["followers"].arrayObject as? [String])!,
                        password: json["password"].stringValue
                    )
                    print(newOrganization)
                    tagOrgs.append(newOrganization)
                }
            }
        }
    }

}
    
extension Organization {
    func toDictionary() -> [String: Any] {
        return [
            "name": self.name,
            "alias": self.alias,
            "location": [
                "address": self.location.address,
                "city": self.location.city,
                "state": self.location.state,
                "country": self.location.country,
                "zip": self.location.zip
            ],
            "contact": [
                "email": self.contact.email,
                "first_phone": self.contact.first_phone,
                "second_phone": self.contact.second_phone
            ],
            "serviceHours": self.serviceHours,
            "website": self.website,
            "socialMedia": [
                "facebook": self.socialMedia.facebook,
                "twitter": self.socialMedia.twitter,
                "instagram": self.socialMedia.instagram,
                "linkedIn": self.socialMedia.linkedIn,
                "youtube": self.socialMedia.youtube, // Added youtube
                "tiktok": self.socialMedia.tiktok, // Added tiktok
                "whatsapp": self.socialMedia.whatsapp // Added whatsapp
            ],
            "followers": self.followers,
            "password": self.password,
            "missionStatement": self.missionStatement,
            "logo": self.logo,
            "tags": self.tags,
            "RFC": self.RFC,
            "postId": self.postId
        ]
    }
}

