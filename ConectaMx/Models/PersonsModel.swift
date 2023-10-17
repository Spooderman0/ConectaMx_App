// PersonModel.swift
/*
import SwiftUI
import SwiftyJSON
import Alamofire

@Observable
class PersonModel {
    var persons = [Person]()
    
    init() {
        
    }
    
    func fetchPersons() {
        persons.removeAll()
        
        let url = "http://10.14.255.172:5000/get_clients"
        
        AF.request(url, method: .get, encoding: URLEncoding.default).responseData { [self] data in
            if let error = data.error{
                print("Error de conexion")
            }else{
                
                let json = try! JSON(data: data.data!)
            
            if json.count > 0 {
                let person = json[0]
                let newPerson = Person(
                    id: person["_id"].stringValue,
                    name: person["name"].stringValue,
                    phone: person["phone"].stringValue,
                    email: person["email"].stringValue,
                    interestedTags: (person["interestedTags"].arrayObject as? [String])!,
                    favorites: (person["favorites"].arrayObject as? [String])!
                )
                
                persons.append(newPerson)
                }
            }
        }
    }
}
*/

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
        let urlString = "\(baseURL)/add_client"
        
        AF.request(urlString, method: .post,encoding: URLEncoding.default).response { response in
            switch response.result {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }

//    func updatePerson(phone: String, client: Person, completion: @escaping (Bool) -> Void) {
//        let urlString = "\(baseURL)/update_client/\(phone)"
//        
//        AF.request(urlString, method: .put,encoding: URLEncoding.default).response { response in
//            switch response.result {
//            case .success(_):
//                completion(true)
//            case .failure(_):
//                completion(false)
//            }
//        }
//    }
    
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
                        interestedTags: (json["interestedTags"].arrayObject as? [String])!,
                        favorites: (json["favorites"].arrayObject as? [String])!
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

