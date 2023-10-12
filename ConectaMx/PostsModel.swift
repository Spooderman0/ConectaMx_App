
// PostModel.swift
import SwiftUI
import SwiftyJSON
import Alamofire

@Observable
class PostModel {
    var posts = [Post]()
    
    init() {
        
    }
    
    func fetchPosts() {
        posts.removeAll()
        
       let url = "http://10.14.255.172:5000/get_posts"
        
        AF.request(url, method: .get, encoding: URLEncoding.default).responseData { [self] data in
            if let error = data.error{
                print("Error de conexion")
            }else{
                
                let json = try! JSON(data: data.data!)
            
            if json.count > 0 {
                let post = json[0]
                let newPost = Post(
                    id: post["_id"].stringValue,
                    title: post["title"].stringValue,
                    content: post["content"].stringValue,
                    organizationId: post["organizationId"].stringValue,
                    createdAt: post["createdAt"].stringValue,
                    updatedAt: post["updatedAt"].stringValue
                )
                
                posts.append(newPost)
            }
            }
        }
    }
}

