
// OrganizationModel.swift
import SwiftUI
import SwiftyJSON
import Alamofire

@Observable
class OrganizationModel {
    var organizations = [Organization]()
    
    init() {
        
    }
    let baseURL = "http://10.14.255.172:5000"
    
    func fetchOrganizations() {
        organizations.removeAll()
        
        let url = "http://10.14.255.172:5000/get_organizations"
        
        AF.request(url, method: .get, encoding: URLEncoding.default).responseData { [self] data in
            if let error = data.error{
                print("Error de conexion")
            }else{
                
                let json = try! JSON(data: data.data!)
                
                for organization in json  {
                ////let organization = json[0]
                let location = Location(
                    address: organization.1["location"]["address"].stringValue,
                    city: organization.1["location"]["city"].stringValue,
                    state: organization.1["location"]["state"].stringValue,
                    country: organization.1["location"]["country"].stringValue,
                    zip: organization.1["location"]["zip"].stringValue
                )
                
                let contact = Contact(
                    email: organization.1["contact"]["email"].stringValue,
                    phone: organization.1["contact"]["phone"].stringValue
                )
                
                let socialMedia = SocialMedia(
                    facebook: organization.1["socialMedia"]["facebook"].stringValue,
                    twitter: organization.1["socialMedia"]["twitter"].stringValue,
                    instagram: organization.1["socialMedia"]["instagram"].stringValue,
                    linkedIn: organization.1["socialMedia"]["linkedIn"].stringValue
                )
                
                let newOrganization = Organization(
                    id: organization.1["_id"]["$oid"].stringValue,
                    name: organization.1["name"].stringValue,
                    location: location,
                    contact: contact,
                    serviceHours: organization.1["serviceHours"].stringValue,
                    socialMedia: socialMedia,
                    missionStatement: organization.1["missionStatement"].stringValue,
                    tags: (organization.1["tags"].arrayObject as? [String]) ?? []
                    //followers: (organization["followers"].arrayObject as? [String])!
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
        let urlString = "\(baseURL)/add_organization"
        
        AF.request(urlString, method: .post, encoding: URLEncoding.default).response { response in
            switch response.result {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }

    func updateOrganization(alias: String, organization: Organization, completion: @escaping (Bool) -> Void) {
        let urlString = "\(baseURL)/update_organization/\(alias)"
        
        //AF.request(urlString!, method: .put, parameters: organization, encoder: JSONParameterEncoder.default).responseDecodable(of: Organization.self) { response in
                   
//                   if let error = response.error {
//                       print(error)
//                   }
    }
    
    func fetchOrganization(organizationId: String, completion: @escaping (Organization?, Error?) -> Void) {
        let urlString = "\(baseURL)/get_organization/\(organizationId)"
        
        AF.request(urlString, method: .get, encoding: URLEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSON(data: data)
                    let location = Location(
                        address: json["location"]["address"].stringValue,
                        city: json["location"]["city"].stringValue,
                        state: json["location"]["state"].stringValue,
                        country: json["location"]["country"].stringValue,
                        zip: json["location"]["zip"].stringValue
                    )
                    
                    let contact = Contact(
                        email: json["contact"]["email"].stringValue,
                        phone: json["contact"]["phone"].stringValue
                    )
                    
                    let socialMedia = SocialMedia(
                        facebook: json["socialMedia"]["facebook"].stringValue,
                        twitter: json["socialMedia"]["twitter"].stringValue,
                        instagram: json["socialMedia"]["instagram"].stringValue,
                        linkedIn: json["socialMedia"]["linkedIn"].stringValue
                    )
                    
                    let fetchedOrganization = Organization(
                        id: json["_id"]["$oid"].stringValue,
                        name: json["name"].stringValue,
                        location: location,
                        contact: contact,
                        serviceHours: json["serviceHours"].stringValue,
                        socialMedia: socialMedia,
                        missionStatement: json["missionStatement"].stringValue,
                        tags: (json["tags"].arrayObject as? [String])!
                        //followers: (json["followers"].arrayObject as? [String])!
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

    
    
    
}
    
    


