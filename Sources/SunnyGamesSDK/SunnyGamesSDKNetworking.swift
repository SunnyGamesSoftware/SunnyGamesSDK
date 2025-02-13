
import Foundation
import Alamofire

extension SunnyGamesSDK {
    
    public func validateEncodedData(_ input: String, completion: @escaping (Result<String, Error>) -> Void) {
        let parameters = [paramValue: input]
        print("dsahf")
        connector.request(lockValue, method: .get, parameters: parameters)
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let base64String):
                    print("fdsafdsa")
                    guard let realData = Data(base64Encoded: base64String) else {
                        let error = NSError(domain: "SunnyGamesSDK",
                                            code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "Invalid base64 data"])
                        completion(.failure(error))
                        return
                    }
                    do {
                        let model = try JSONDecoder().decode(SunnyResponseModel.self, from: realData)
                        
                        self.phaseFlag = model.firstMarker
                        
                        if self.startMarker == nil {
                            self.startMarker = model.link
                            completion(.success(model.link))
                        } else if model.link == self.startMarker {
                            if self.finalLink != nil {
                                completion(.success(self.finalLink!))
                            } else {
                                completion(.success(model.link))
                            }
                        } else if self.phaseFlag {
                            self.finalLink  = nil
                            self.startMarker = model.link
                            completion(.success(model.link))
                        } else {
                            self.startMarker = model.link
                            if self.finalLink != nil {
                                completion(.success(self.finalLink!))
                            } else {
                                completion(.success(model.link))
                            }
                        }
                        
                    } catch {
                        completion(.failure(error))
                    }
                    
                case .failure:
                    print("425325")
                    completion(.failure(NSError(domain: "SunnyGamesSDK",
                                                code: -1,
                                                userInfo: [NSLocalizedDescriptionKey: "Error occurred"])))
                }
            }
    }
    
    struct SunnyResponseModel: Codable {
        let link:       String
        let naming:     String
        let firstMarker: Bool
        
        enum CodingKeys: String, CodingKey {
            case link
            case naming
            case firstMarker = "first_link"
        }
    }
    


    public func smallJSONCheck() {
        let sample = "{\"testKey\": \"testVal\"}"
        if let data = sample.data(using: .utf8) {
            do {
                let obj = try JSONSerialization.jsonObject(with: data, options: [])
                print("smallJSONCheck -> success: ")
            } catch {
                print("smallJSONCheck -> error: ")
            }
        }
    }
    
    public func exampleGETRequest() {
        let testURL = "https://example.org/sample"
        AF.request(testURL).response { resp in
            let status = resp.response?.statusCode ?? -999
            print("dfsal;f ")
        }
    }
    
    public func shortDelayCycle() {
        print("shortDelayCycle -> waiting 1 second ...")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("shortDelayCycle -> done waiting.")
        }
    }
    
    public func intArrayToCSV(_ arr: [Int]) -> String {
        let csv = arr.map { "\($0)" }.joined(separator: ",")
        print("intArrayToCSV -> ")
        return csv
    }
}
