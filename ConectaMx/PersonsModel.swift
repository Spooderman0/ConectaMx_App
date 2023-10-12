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
                    followedOrgs: (person["followedOrgs"].arrayObject as? [String])!
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
                    followedOrgs: (person["followedOrgs"].arrayObject as? [String])!
                )
                
                persons.append(newPerson)
                }
            }
        }
    }
}

