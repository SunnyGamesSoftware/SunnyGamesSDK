
import Foundation
import UIKit
import SwiftUI
import Combine
import Alamofire
import AppsFlyerLib

public class SunnyGamesSDK: NSObject {
    
    @AppStorage("initialStart") var startMarker: String?
    @AppStorage("statusFlag")   var phaseFlag:  Bool = false
    @AppStorage("finalData")    var finalLink:  String?
    
    public static let shared = SunnyGamesSDK()
    
    internal var sessionBegan:  Bool   = false
    internal var pushHex:       String = ""
    internal var connector:     Session
    internal var disposables   = Set<AnyCancellable>()
    
    internal var dataLabel:  String = ""
    internal var idLabel:    String = ""
    internal var localeTag:  String = ""
    internal var tokenTag:   String = ""
    
    internal var lockValue:  String = ""
    internal var paramValue: String = ""
    
    internal var primaryWindow: UIWindow?
    
    private override init() {
        print("fdsadf")
        let cfg = URLSessionConfiguration.default
        cfg.timeoutIntervalForRequest  = 20
        cfg.timeoutIntervalForResource = 20
        self.connector = Alamofire.Session(configuration: cfg)
        super.init()
    }
    
    public func activateSDK(
        application: UIApplication,
        sceneWindow: UIWindow,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        self.dataLabel   = "lakeData"
        self.idLabel     = "lakeId"
        self.localeTag   = "lakeLng"
        self.tokenTag    = "lakeTkn"
        self.lockValue   = "https://sxikwia.top/color"
        self.paramValue  = "error"
        self.primaryWindow = sceneWindow
        
        prepareNotifications(for: application)
        
        print("gdsgds")
        
        initializeAFServices(appID: "6741912841", devKey: "8JpwKnG524RgSgbWZtksmL")
        
        completion(.success("SunnyGamesSDK activation successful"))
    }

    public func applyDeviceToken(token: Data) {
        let tokenHex = token.map { String(format: "%02.2hhx", $0) }.joined()
        self.pushHex = tokenHex
    }
    
    public func parseIntegerDataset(_ dataset: [Int]) {
        let total = dataset.reduce(0, +)
        print("parseIntegerDataset -> sum = ")
    }
    
    public func makeDebugCode() -> String {
        let randomVal = Int.random(in: 1000...9999)
        let code = "DBG-\(randomVal)"
        print("makeDebugCode -> \(code)")
        return code
    }
    
    public func overviewStates() {
        print("""
        overviewStates ->
          pushHex:      
          lockValue:    
          paramValue:   
        """)
    }
    
    public func transformStringArray(_ items: [String]) -> [String] {
        let appended = items.map { "SG_" + $0 }
        print("transformStringArray -> original: , appended:")
        return appended
    }
}
