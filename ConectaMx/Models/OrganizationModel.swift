
// OrganizationModel.swift
import SwiftUI
import SwiftyJSON
import Alamofire

@Observable
class OrganizationModel {
    var organizations = [Organization]()
    
    init() {
        
    }
    
    func fetchOrganizations() {
        organizations.removeAll()
        
        let url = "http://10.14.255.172:5000/get_organizations"
        
        AF.request(url, method: .get, encoding: URLEncoding.default).responseData { [self] data in
            if let error = data.error{
                print("Error de conexion")
            }else{
                
                let json = try! JSON(data: data.data!)
                
                if json.count > 0  {
                let organization = json[0]
                let location = Location(
                    address: organization["location"]["address"].stringValue,
                    city: organization["location"]["city"].stringValue,
                    state: organization["location"]["state"].stringValue,
                    country: organization["location"]["country"].stringValue,
                    zip: organization["location"]["zip"].stringValue
                )
                
                let contact = Contact(
                    email: organization["contact"]["email"].stringValue,
                    phone: organization["contact"]["phone"].stringValue
                )
                
                let socialMedia = SocialMedia(
                    facebook: organization["socialMedia"]["facebook"].stringValue,
                    twitter: organization["socialMedia"]["twitter"].stringValue,
                    instagram: organization["socialMedia"]["instagram"].stringValue,
                    linkedIn: organization["socialMedia"]["linkedIn"].stringValue
                )
                
                let newOrganization = Organization(
                    id: organization["_id"].stringValue,
                    name: organization["name"].stringValue,
                    location: location,
                    contact: contact,
                    serviceHours: organization["serviceHours"].stringValue,
                    socialMedia: socialMedia,
                    missionStatement: organization["missionStatement"].stringValue,
                    tags: (organization["tags"].arrayObject as? [String])!
                   // followers: (organization["followers"].arrayObject as? [String])!
                )
                print(newOrganization)
                organizations.append(newOrganization)
            }
            }
        }
    }
}

