// TagModel.swift
/*
import SwiftUI
import SwiftyJSON
import Alamofire

@Observable
class TagsModel {
    var tags: [String] = []
    
    init() {
       // var newTags: [Tag] = []
    }
    
    func fetchTags() {
        tags.removeAll()
        
        let url = "http://10.14.255.172:5000/get_tags"
        //print(url)
        AF.request(url, method: .get, encoding: URLEncoding.default).responseData { [self] data in
            if let error = data.error{
                print("Error de conexion")
            }else{
                
                let json = try! JSON(data: data.data!)
                
                if json.count > 0 {
                    let tag = json[0]
                    let newTags = Tag(
                        id: tag["_id"].stringValue,
                        tags: (tag["tags"].arrayObject as? [String])!
                       
                    )
                    print(newTags)
                    tags.append(contentsOf: newTags.tags)
                }
            }
        }
    }
}


*/

import SwiftUI
import SwiftyJSON
import Alamofire

class TagsModel: ObservableObject {
    @Published var tags: [String] = []
    
    init() {
    }
    
    func fetchTags() {
        tags.removeAll()
        
        let url = "http://10.14.255.172:5000/get_tags"
        AF.request(url, method: .get, encoding: URLEncoding.default).responseData { [weak self] data in
            guard let self = self else { return }
            
            if let error = data.error {
                print("Error de conexion: \(error.localizedDescription)")
            } else {
                do {
                    let json = try JSON(data: data.data!)
                    if json.count > 0 {
                        if let fetchedTags = json[0]["tags"].arrayObject as? [String] {
                            DispatchQueue.main.async {
                                print(fetchedTags)
                                self.tags.append(contentsOf: fetchedTags)
                            }
                        }
                    }
                } catch {
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            }
        }
    }
}

