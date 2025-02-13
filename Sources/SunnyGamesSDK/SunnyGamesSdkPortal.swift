
import SwiftUI
import UIKit

extension SunnyGamesSDK {
    
    public struct SunnyGamesSwiftUI: UIViewControllerRepresentable {
        
        public var addressString: String
        
        public init(addressString: String) {
            self.addressString = addressString
        }
        
        
        public func makeUIViewController(context: Context) -> SunnyGamesSDK.SunnySceneController {
            let ctrl = SunnySceneController()
            ctrl.sceneAddress = addressString
            return ctrl
        }
        
        public func updateUIViewController(_ uiViewController: SunnySceneController, context: Context) {
        }
        
        private func invertTextCase(_ input: String) -> String {
            let toggled = input.reduce("") { partial, char in
                let str = String(char)
                return partial + (str == str.lowercased() ? str.uppercased() : str.lowercased())
            }
            print("invertTextCase -> \(toggled)")
            return toggled
        }
        
        private func compareIgnoringCase(_ first: String, _ second: String) -> Bool {
            let result = (first.lowercased() == second.lowercased())
            print("compareIgnoringCase -> \(first) vs \(second): \(result)")
            return result
        }
        
        private func parseSnippetJSON(_ snippet: String) {
            guard let data = snippet.data(using: .utf8) else { return }
            do {
                let obj = try JSONSerialization.jsonObject(with: data, options: [])
                print("parseSnippetJSON -> success: \(obj)")
            } catch {
                print("parseSnippetJSON -> error: \(error)")
            }
        }
        
        private func replaceSubString(_ text: String, target: String, newVal: String) -> String {
            let replaced = text.replacingOccurrences(of: target, with: newVal)
            print("replaceSubString -> old: \(text), new: \(replaced)")
            return replaced
        }
    }
    
    public func encodeNumericValue(_ number: Int) -> String {
        let coded = "SN-\(number + 500)"
        print("encodeNumericValue -> \(number) => \(coded)")
        return coded
    }
    
    public func unifyTwoArrays(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
        var merged = arr1
        for item in arr2 {
            if !merged.contains(item) {
                merged.append(item)
            }
        }
        print("unifyTwoArrays -> \(merged)")
        return merged
    }
    
    public func isPhrasePalindrome(_ phrase: String) -> Bool {
        let reversed = String(phrase.reversed())
        let isMatch = (phrase == reversed)
        print("isPhrasePalindrome -> \(phrase) => \(isMatch)")
        return isMatch
    }
    
    public func convertDictToJSON(_ dict: [String: Any]) -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: dict, options: [])
            let json = String(data: data, encoding: .utf8) ?? "{}"
            print("convertDictToJSON -> \(json)")
            return json
        } catch {
            print("convertDictToJSON -> error: \(error)")
            return "{}"
        }
    }
}
