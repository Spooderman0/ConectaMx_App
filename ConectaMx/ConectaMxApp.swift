//
//  ConectaMxApp.swift
//  ConectaMx
//
//  Created by Guillermo Garcia Acosta on 18/09/23.
//

import SwiftUI
import SwiftData
import UIKit
import UserNotificationsUI
import UserNotifications
import Foundation




//class ViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        checkForPermission()
//    }
//    
//    func checkForPermission() {
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.getNotificationSettings{settings in
//            switch settings.authorizationStatus{
//            case .authorized:
//                self.dispatchNotification()
//            case .denied:
//                return
//            case .notDetermined:
//                notificationCenter.requestAuthorization(options: [.alert, .sound]){ didAllow, error in
//                    if didAllow{
//                        self.dispatchNotification()
//                    }
//                    
//                }
//            default:
//                return
//            }
//        }
//    }
//    
//    func dispatchNotification(){
//        let identifier = "conecta-prueba-notification"
//        let title = "Revisa nuestras organizaciones!"
//        let body = "Mira las distintas organizaciones que hay a tu alrededor"
//        let hour = 18
//        let minute = 10
//        let isDaily = true
//        
//        let notificationCenter = UNUserNotificationCenter.current()
//        
//        let content = UNMutableNotificationContent()
//        content.title = title
//        content.body = body
//        content.sound = .default
//        
//        let calendar = Calendar.current
//        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
//        dateComponents.hour = hour
//        dateComponents.minute = minute
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
//        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//        
//        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
//        notificationCenter.add(request)
//    }
//}

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

@main
struct ConectaMxApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
