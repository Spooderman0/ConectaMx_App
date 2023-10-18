
import SwiftUI
import SwiftyJSON
import Alamofire

class PersonModel: ObservableObject {
    @Published var persons = [Person]()
    @Published var fetchedPerson: Person?
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
    
//    func login(phone: String, password: String, completion: @escaping (Bool, String?) -> Void) {
//        let urlString = "http://10.14.255.172:5000/login_client"
//
//        // Parameters based on the API expectations
//        let parameters: [String: Any] = [
//            "phone": phone,
//            "password": password
//        ]
//
//        // Alamofire POST request
//        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//
//                if let message = json["message"].string {
//                    completion(true, message)  // Login successful
//                } else if let error = json["error"].string {
//                    completion(false, error)  // Login failed with an error message
//                } else {
//                    completion(false, "Unknown error")  // An unknown error occurred
//                }
//
//            case .failure(let error):
//                completion(false, error.localizedDescription)  // Handling failure in network request
//            }
//        }
//    }
    
    func login(phone: String, password: String, completion: @escaping (Bool, Person?, String?) -> Void) {
        let urlString = "http://10.14.255.172:5000/login_client"
        
        let parameters: [String: Any] = [
            "phone": phone,
            "password": password
        ]
        
        AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if response.response?.statusCode == 200 {
                    if let personJSON = json.dictionary {
                        let person = Person(
                            id: personJSON["id"]?.string ?? "",
                            name: personJSON["name"]?.string ?? "",
                            phone: personJSON["phone"]?.string ?? "",
                            email: personJSON["email"]?.string ?? "",
                            password: personJSON["password"]?.string ?? "",
                            interestedTags: personJSON["interestedTags"]?.arrayObject as? [String] ?? [],
                            favorites: personJSON["favorites"]?.arrayObject as? [String] ?? []
                        )
                        
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
    
    func getFavoritesByPhone(phone: String, completion: @escaping ([String]?, Error?) -> Void) {
        let urlString = "\(baseURL)/get_favorites_by_phone/\(phone)"
        
        AF.request(urlString, method: .get, encoding: URLEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSON(data: data)
                    if let favoritesArray = json.arrayObject as? [String] {
                        completion(favoritesArray, nil)
                    } else {
                        completion(nil, NSError(domain: "", code: -1, userInfo: ["message": "Invalid data format"]))
                    }
                } catch {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}

