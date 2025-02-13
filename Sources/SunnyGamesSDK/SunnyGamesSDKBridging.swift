
import UIKit
import SwiftUI
import WebKit

extension SunnyGamesSDK {
    
    public func presentScene(with address: String) {
        self.primaryWindow = UIWindow(frame: UIScreen.main.bounds)
        let sceneCtrl = SunnySceneController()
        sceneCtrl.sceneAddress = address
        let nav = UINavigationController(rootViewController: sceneCtrl)
        self.primaryWindow?.rootViewController = nav
        self.primaryWindow?.makeKeyAndVisible()
    }
    
    public class SunnySceneController: UIViewController, WKNavigationDelegate, WKUIDelegate {
        
        private var sceneCanvas: WKWebView!
        
        @AppStorage("savedData")  var storedData: String?
        @AppStorage("statusFlag") var localFlag: Bool = false
        
        public var sceneAddress: String!
        
        public override func viewDidLoad() {
            super.viewDidLoad()
            
            let engineCfg = WKWebViewConfiguration()
            engineCfg.preferences.javaScriptEnabled = true
            engineCfg.preferences.javaScriptCanOpenWindowsAutomatically = true
            
            let metaScript = """
            var meta = document.createElement('meta');
            meta.name = 'viewport';
            meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
            document.getElementsByTagName('head')[0].appendChild(meta);
            """
            let userScript = WKUserScript(source: metaScript,
                                          injectionTime: .atDocumentEnd,
                                          forMainFrameOnly: true)
            engineCfg.userContentController.addUserScript(userScript)
            
            sceneCanvas = WKWebView(frame: .zero, configuration: engineCfg)
            sceneCanvas.isOpaque                            = false
            sceneCanvas.backgroundColor                     = .white
            sceneCanvas.uiDelegate                          = self
            sceneCanvas.navigationDelegate                  = self
            sceneCanvas.allowsBackForwardNavigationGestures = true
            
            view.addSubview(sceneCanvas)
            sceneCanvas.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                sceneCanvas.topAnchor.constraint(equalTo: view.topAnchor),
                sceneCanvas.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                sceneCanvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                sceneCanvas.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            loadSceneAddress()
        }
        
        public override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationItem.largeTitleDisplayMode = .never
            navigationController?.isNavigationBarHidden = true
        }
        
        private func loadSceneAddress() {
            guard let encoded = sceneAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                  let finalURL = URL(string: encoded) else { return }
            let request = URLRequest(url: finalURL)
            sceneCanvas.load(request)
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if SunnyGamesSDK.shared.finalLink == nil {
                let final = webView.url?.absoluteString ?? ""
                SunnyGamesSDK.shared.finalLink = final
                print("kjsandf")
            }
        }
        
        public func webView(_ webView: WKWebView,
                            create canvasCfg: WKWebViewConfiguration,
                            for navAction: WKNavigationAction,
                            windowFeatures: WKWindowFeatures) -> WKWebView? {
            
            let popCanvas = WKWebView(frame: .zero, configuration: canvasCfg)
            popCanvas.navigationDelegate = self
            popCanvas.uiDelegate         = self
            popCanvas.allowsBackForwardNavigationGestures = true
            
            sceneCanvas.addSubview(popCanvas)
            popCanvas.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                popCanvas.topAnchor.constraint(equalTo: sceneCanvas.topAnchor),
                popCanvas.bottomAnchor.constraint(equalTo: sceneCanvas.bottomAnchor),
                popCanvas.leadingAnchor.constraint(equalTo: sceneCanvas.leadingAnchor),
                popCanvas.trailingAnchor.constraint(equalTo: sceneCanvas.trailingAnchor)
            ])
            
            return popCanvas
        }
        
        private func measureSceneBounds() {
            let w = sceneCanvas.scrollView.contentSize.width
            let h = sceneCanvas.scrollView.contentSize.height
            print("measureSceneBounds -> \(w)x\(h)")
        }
        
        private func runSceneJavaScript() {
            let snippet = "oieqwr321"
            sceneCanvas.evaluateJavaScript(snippet) { _, err in
                if let e = err {
                    print("runSceneJavaScript -> error:")
                } else {
                    print("runSceneJavaScript -> success.")
                }
            }
        }
        
        private func checkBackwardAbility() {
            let canGo = sceneCanvas.canGoBack
            print("checkBackwardAbility -> ")
        }
        
        private func delayedSceneReload() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print("delayedSceneReload -> reloading sceneCanvas.")
                self.sceneCanvas.reload()
            }
        }
    }
}
