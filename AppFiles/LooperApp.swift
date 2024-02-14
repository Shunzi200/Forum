//
//  LooperApp.swift
//  Looper
//
//  Created by Samuel Ridet on 8/14/22.
//

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseMessaging
import FirebaseAnalytics
import UserNotifications
//import FirebaseAppCheck
import CoreLocation
import FirebaseAuth
import GoogleSignIn

class AppState: ObservableObject {
    @Published var chatID = ""
    @Published var showChat = false
    @Published var offer = false
    @Published var sentOffers = false
    @Published var showSell = false
    @Published var chat = Chat(id: "", members: [], lastMessage: "", listingID: "", offerPrice: "", date: "", opened: false, lastSender: "")
    @Published var defaultImage = ""
    @Published var sku = ""
    @Published var name = ""
    
    static let shared = AppState()
    
    private init() {}
}

@main
struct LooperApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    @StateObject var firestoreConnector = FirebaseConnector()
    @StateObject var authModel = AuthViewModel()
    
    @State private var functionComplete = false
    @StateObject var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
           
            holder()
                .environmentObject(authModel)
                .environmentObject(firestoreConnector)
                .environmentObject(appState)
        }
        
    }
}







class AppDelegate: UIResponder, UIApplicationDelegate { // Conform to CLLocationManagerDelegate


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        if let userID = Auth.auth().currentUser?.uid {
            let pushManager = PushNotificationManager(userID: userID)
            pushManager.registerForPushNotifications()
            pushManager.updateFirestorePushTokenIfNeeded()
        }
        Analytics.logEvent(AnalyticsEventAppOpen, parameters: [:
        ])

        
        return true
    }

    
   
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Registered for Apple Remote Notifications")
        
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
        Messaging.messaging().apnsToken = deviceToken
        
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
                // Get the badge count from the incoming notification
            if let badgeCount = userInfo["badge"] as? Int {
                    // Get the current badge count
                let currentBadgeCount =  UIApplication.shared.applicationIconBadgeNumber
                    // Calculate the new badge count
                let newBadgeCount = currentBadgeCount + badgeCount
                    // Set the new badge count
                UIApplication.shared.applicationIconBadgeNumber = newBadgeCount
            }
        }



    }

  
     
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("user launched with notification")
        AppState.shared.chatID = ""
        AppState.shared.offer = false
        AppState.shared.sentOffers = false
        
        print("user tapped the notification bar when the app is in background")
        
        let userInfo = response.notification.request.content.userInfo
        
        if let chatID = userInfo["chatID"] as? String {
            AppState.shared.chatID = chatID
            AppState.shared.showChat = (chatID == "" ? false : true)
        }
        
        if let offer = userInfo["offer"] as? String {
            AppState.shared.offer = (offer == "" ?  false : true)
        }
        
        if let sentOffer = userInfo["sentOffer"] as? String {
            AppState.shared.sentOffers = (sentOffer == "" ?  false : true)
        }
        
        if let sku = userInfo["sku"] as? String {
            AppState.shared.showSell = (sku == "" ?  false : true)
            AppState.shared.sku = sku
        }
        
        if let name = userInfo["name"] as? String {
            AppState.shared.name = name
     
        }
        
        if let picture = userInfo["picture"] as? String {
            AppState.shared.defaultImage = picture
            
        }
        
        
        completionHandler()
    }
}




