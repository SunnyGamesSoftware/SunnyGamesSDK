
import Foundation
import UIKit
import UserNotifications

extension SunnyGamesSDK {
    
    public func prepareNotifications(for application: UIApplication) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { allowed, _ in
            if allowed {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                    print("4332fds")
                }
            } else {
                print("prepareNotifications -> user disallowed notifications.")
            }
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleSDKActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    public func pushNotice(name: String, details: String) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: NSNotification.Name(name),
                object: nil,
                userInfo: ["notificationMessage": details]
            )
        }
    }
    
    public func pushError(name: String) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: NSNotification.Name(name),
                object: nil,
                userInfo: ["notificationMessage": "Error occurred"]
            )
        }
    }
    
    public func inspectNotificationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("inspectNotificationStatus -> status raw: ")
        }
    }
    
    public func setLocalQuietMode(_ on: Bool) {
        print("setLocalQuietMode -> now: \(on ? "ON" : "OFF")")
    }
    
    public func evaluateNoticeData(_ data: [String: Any]) {
        print("evaluateNoticeData -> total keys: ")
    }
    
    public func scheduleReminderMarker() {
        print("scheduleReminderMarker -> would normally set local notification.")
    }
}
