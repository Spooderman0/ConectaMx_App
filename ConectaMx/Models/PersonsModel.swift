
import SwiftUI
import SwiftyJSON
import Alamofire

class PersonModel: ObservableObject {
    @Published var persons = [Person]()
    @Published var fetchedPerson: Person?
    @Published var favOrgs: [Organization] = []
    init() {
        
    }
    let baseURL = "http://10.14.255.172:5000"
    
    func fetchPersons() {
        persons.removeAll()
        
        let url = "http://10.14.255.172:5000/get_clients"
        
        AF.request(url, method: .get, encoding: URLEncoding.default).responseData { [self] data in
            if let error = data.error{
                print("Error de conexion")
            }else{
                
                let json = try! JSON(data: data.data!)
            
            for person in json{
                //let person = json[0]
                let newPerson = Person(
                    id: person.1["_id"]["$oid"].stringValue,
                    name: person.1["name"].stringValue,
                    phone: person.1["phone"].stringValue,
                    email: person.1["email"].stringValue,
                    password: person.1["password"].stringValue,
                    interestedTags: (person.1["interestedTags"].arrayObject as? [String])!,
                    favorites: (person.1["favorites"].arrayObject as? [String])!
                )
                print(newPerson)
                persons.append(newPerson)
                }
              
                }
            }
        }

    func postPerson(person: Person, completion: @escaping (Bool) -> Void) {
        let urlString = "\(baseURL)/register_client"
        
        // Convert Person instance to a dictionary
        let parameters: [String: Any] = [
            "name": person.name,
            "phone": person.phone,
            "email": person.email,
            "password": person.password,
            "interestedTags": person.interestedTags,
            "favorites": person.favorites
        ]
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }

    func login(phone: String, password: String, completion: @escaping (Bool, Person?, String?) -> Void) {
        let urlString = "http://10.14.255.172:5000/login_client"
        
        let parameters: [String: Any] = [
            "phone": phone,
            "password": password
        ]
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if response.response?.statusCode == 200 {
                    if let clientInfoJSON = json["client_info"].dictionary {
                        let person = Person(
                            id: "", 
                            name: clientInfoJSON["name"]?.string ?? "",
                            phone: clientInfoJSON["phone"]?.string ?? "",
                            email: clientInfoJSON["email"]?.string ?? "",
                            password: clientInfoJSON["password"]?.string ?? "",
                            interestedTags: clientInfoJSON["interestedTags"]?.arrayObject as? [String] ?? [],
                            favorites: clientInfoJSON["favorites"]?.arrayObject as? [String] ?? []
                        )
                        self.fetchedPerson = person
                        completion(true, person, nil)
                    }
                } else {
                    let errorMessage = json["error"].string ?? "Unknown error occurred"
                    completion(false, nil, errorMessage)
                }
                
            case .failure(let error):
                completion(false, nil, error.localizedDescription)
            }
        }
    }


    
    func updatePersonTags(phone: String, newTags: [String], completion: @escaping (Bool) -> Void) {
        let urlString = "\(baseURL)/update_client/\(phone)"
        let params: [String: Any] = ["interestedTags": newTags]
        
        AF.request(urlString, method: .put, parameters: params, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
    
    func fetchPerson(phoneNumber: String, completion: @escaping (Person?, Error?) -> Void) {
        let urlString = "\(baseURL)/get_client/\(phoneNumber)"
        
        AF.request(urlString, method: .get, encoding: URLEncoding.default).responseData { [self] response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSON(data: data)
                    let personTarget = Person(
                        id: json["_id"]["$oid"].stringValue,
                        name: json["name"].stringValue,
                        phone: json["phone"].stringValue,
                        email: json["email"].stringValue,
                        password: json["password"].stringValue,
                        interestedTags: (json["interestedTags"].arrayObject as? [String]) ?? [],
                        favorites: (json["favorites"].arrayObject as? [String]) ?? []
                    )
                    self.fetchedPerson = personTarget  // Set the fetched person property
                    completion(personTarget, nil)
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    
    func getFavoritesByPhone(phone: String, completion: @escaping ([Organization]?, Error?) -> Void) {
        let urlString = "\(baseURL)/get_favorites_by_phone/\(phone)"
        
        AF.request(urlString, method: .get, encoding: URLEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSON(data: data)
                    var organizations = [Organization]()
                    
                    for organizationData in json.arrayValue {
                        // You might need to adjust this part based on the actual JSON structure
                        let location = Location(
                            address: organizationData["location"]["address"].stringValue,
                            city: organizationData["location"]["city"].stringValue,
                            state: organizationData["location"]["state"].stringValue,
                            country: organizationData["location"]["country"].stringValue,
                            zip: organizationData["location"]["zip"].stringValue
                        )
                        
                        let contact = Contact(
                            email: organizationData["contact"]["email"].stringValue,
                            first_phone: organizationData["contact"]["first_phone"].stringValue,
                            second_phone: organizationData["contact"]["second_phone"].stringValue
                        )
                        
                        let socialMedia = SocialMedia(
                            facebook: organizationData["socialMedia"]["facebook"].stringValue,
                            twitter: organizationData["socialMedia"]["twitter"].stringValue,
                            instagram: organizationData["socialMedia"]["instagram"].stringValue,
                            linkedIn: organizationData["socialMedia"]["linkedIn"].stringValue,
                            youtube: organizationData["socialMedia"]["youtube"].stringValue, // Added youtube
                            tiktok: organizationData["socialMedia"]["tiktok"].stringValue, // Added tiktok
                            whatsapp: organizationData["socialMedia"]["whatsapp"].stringValue // Added whatsapp
                        )
                        
                        let organization = Organization(
                            id: organizationData["_id"]["$oid"].stringValue,
                            name: organizationData["name"].stringValue,
                            alias: organizationData["alias"].stringValue,
                            location: location,
                            contact: contact,
                            serviceHours: organizationData["serviceHours"].stringValue,
                            website: organizationData["website"].stringValue,
                            socialMedia: socialMedia,
                            missionStatement: organizationData["missionStatement"].stringValue,
                            logo: organizationData["logo"].stringValue,
                            tags: (organizationData["tags"].arrayObject as? [String]) ?? [],
                            RFC: organizationData["RFC"].stringValue,
                            postId: (organizationData["postId"].arrayObject as? [String]) ?? [],
                            followers: (organizationData["followers"].arrayObject as? [String]) ?? [],
                            password: organizationData["password"].stringValue
                        )
                        self.favOrgs.append(organization)
                    }
                    
                    completion(self.favOrgs, nil)
                    
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }


    
    func addFavoriteByPhone(phone: String, orgId: String, completion: @escaping (Bool, Error?) -> Void) {
        let urlString = "\(baseURL)/add_favorite_by_phone/\(phone)"
        
        let parameters: [String: Any] = [
            "org_id": orgId
        ]
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.value as? [String: Any], let _ = json["message"] as? String {
                    completion(true, nil)
                } else {
                    completion(false, NSError(domain: "", code: -1, userInfo: ["message": "Invalid data format"]))
                }
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    func removeFavoriteByPhone(phone: String, orgId: String, completion: @escaping (Bool, Error?) -> Void) {
        let urlString = "\(baseURL)/remove_favorite_by_phone/\(phone)"
        
        let parameters: [String: Any] = [
            "org_id": orgId
        ]
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.value as? [String: Any], let _ = json["message"] as? String {
                    completion(true, nil)
                } else {
                    completion(false, NSError(domain: "", code: -1, userInfo: ["message": "Invalid data format"]))
                }
            case .failure(let error):
                completion(false, error)
            }
        }
    }


    
}

