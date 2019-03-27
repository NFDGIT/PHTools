//
//  BaseWebView.swift
//  package
//
//  Created by Admin on 2019/2/13.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import WebKit



public enum PHBaseWebViewStatus {
    case fail
    case finish
}
public class PHBaseWebView: WKWebView,WKNavigationDelegate,WKUIDelegate {
    public var webLoadCallBack : ((PHBaseWebViewStatus)->())?
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init() {
        let config : WKWebViewConfiguration = WKWebViewConfiguration()
        config.userContentController = WKUserContentController.init()
        
        let preferences : WKPreferences = WKPreferences.init()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        config.preferences = preferences
        
        super.init(frame: CGRect.zero, configuration: config)
        self.navigationDelegate = self
        self.uiDelegate = self
        
        
    }


}
public extension PHBaseWebView{
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if  (webLoadCallBack != nil) {
            webLoadCallBack!(.fail)
        }
    }
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if  (webLoadCallBack != nil) {
            webLoadCallBack!(.finish)
        }
    }
    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(URLSession.AuthChallengeDisposition.performDefaultHandling,nil)
    }
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler()
        }))
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
