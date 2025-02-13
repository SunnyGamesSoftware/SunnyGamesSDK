
import Foundation
import AppsFlyerLib

extension SunnyGamesSDK: AppsFlyerLibDelegate {
    
    public func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        let rawData   = try! JSONSerialization.data(withJSONObject: conversionInfo, options: .fragmentsAllowed)
        let rawString = String(data: rawData, encoding: .utf8) ?? "{}"
        
        print("sssss")
        
        let finalInput = """
        {
            "\(dataLabel)": \(rawString),
            "\(idLabel)": "\(AppsFlyerLib.shared().getAppsFlyerUID() ?? "")",
            "\(localeTag)": "\(Locale.current.languageCode ?? "")",
            "\(tokenTag)": "\(pushHex)"
        }
        """
        
        validateEncodedData(finalInput) { outcome in
            switch outcome {
            case .success(let detail):
                self.pushNotice(name: "SunnyGamesNote", details: detail)
            case .failure:
                self.pushError(name: "SunnyGamesNote")
            }
        }
    }
    
    public func onConversionDataFail(_ error: any Error) {
        self.pushError(name: "SunnyGamesNote")
    }
    
    @objc func handleSDKActive() {
        if !self.sessionBegan {
            AppsFlyerLib.shared().start()
            self.sessionBegan = true
        }
    }
    
    public func initializeAFServices(appID: String, devKey: String) {
        AppsFlyerLib.shared().appleAppID                   = appID
        AppsFlyerLib.shared().appsFlyerDevKey              = devKey
        AppsFlyerLib.shared().delegate                     = self
        AppsFlyerLib.shared().disableAdvertisingIdentifier = true
    }
    
    
    public func partialAFCheck(_ info: [AnyHashable: Any]) {
        print("partialAFCheck -> item count = \(info.count)")
    }
    
    public func isSDKSessionActive() -> Bool {
        return sessionBegan
    }
    
    public func printAFUID() {
        let uid = AppsFlyerLib.shared().getAppsFlyerUID() ?? "no-uid"
        print("printAFUID ->")
    }
    
    public func minimalAFParse(_ dictionary: [AnyHashable: Any]) {
        if let firstKey = dictionary.keys.first {
            print("minimalAF")
        } else {
            print("minimalAFParse -> empty dictionary")
        }
    }
}
