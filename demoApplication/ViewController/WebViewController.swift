//
//  WebViewController.swift
//  demoApplication
//
//  Created by Macbook  on 8/22/20.
//  Copyright © 2020 mtvd. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var webV: WKWebView!
    var contentHTML: String = ""
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configWeb()
        
        if let url = url {
            webV.load(URLRequest(url: url))
        } else if !contentHTML.isEmpty {
            webV.loadHTMLString(contentHTML, baseURL: nil)
        }
        
        delayCallMethod(timeInterval: 15) {
            //            self.hideLoading()
        }
    }
    
    func delayCallMethod(timeInterval: TimeInterval = 1, finish: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            finish()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.clearCacheWKView(reload: false)
    }
    
    
    private func configWeb() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        webV = WKWebView(frame: view.bounds, configuration: webConfiguration)
        webV.navigationDelegate = self
        webV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webV)
    }
    
    private func reloadOriginPageLogin() {
        if let u = url {
            webV.load(URLRequest(url: u))
        }
    }
    
    private func clearCacheWKView(reload: Bool = true) {
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        webV.stopLoading()
        webV.configuration.userContentController.removeAllUserScripts()
        webV.configuration.userContentController.removeAllContentRuleLists()
        if !reload {
            webV.removeFromSuperview()
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    //get param to a string
    func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //        self.showLoading()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //        hideLoading()
    }
    
    //check faild
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //        hideLoading()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        //        hideLoading()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {
        if (navigationAction.navigationType == .linkActivated){
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}
