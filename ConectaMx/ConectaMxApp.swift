//
//  ConectaMxApp.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 18/09/23.
//

import SwiftUI
import SwiftData

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        DispatchQueue.main.async {
            let center = UNUserNotificationCenter.current()
            center.delegate = self  // Set the delegate
            center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                if granted {
                    NotificationManager.shared.scheduleDailyNotification()
                }
            }
        }
        return true
    }
    
    // This method will be called when the app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show the notification alert and play the sound
        completionHandler([.alert, .sound])
    }
}




@main
struct ConectaMxApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var tagsModel = TagsModel()
    var orgModel = OrganizationModel()
    var postsModel = PostModel()
    var personsModel = PersonModel()

    var body: some Scene {
        WindowGroup {
            Inicio_Sesion()
            //ContentView()
            
            
//            Organization_Tags(tags: tagsModel.tags)
//                .onAppear(){
//                    tagsModel.fetchTags()
//                    orgModel.fetchOrganizations()
//                    postsModel.fetchPosts()
//                   // personsModel.fetchPersons()
//                    personsModel.fetchPerson(phoneNumber: "55-3456-7890") { (person, error) in
//                        if let person = person {
//                            // Handle the retrieved person
//                            print("Retrieved person: \(person.name)")
//                        } else if let error = error {
//                            // Handle the error
//                            print("Error fetching person: \(error.localizedDescription)")
//                        }
//                    }
//                    
//                }
        }
        .modelContainer(for: Item.self)
        
        
    }
}



class NotificationManager {
    
    static let shared = NotificationManager()
    
    private init() {}
    
    func scheduleDailyNotification() {
        let identifier = "conecta-prueba-notification"
        let title = "Revisa nuestras organizaciones!"
        let body = "Mira las distintas organizaciones que hay a tu alrededor"
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)  // Notificación en 5 segundos
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
}
