//
//  Created by Ivano Bilenchi on 16/05/18.
//  Copyright © 2018 Ivano Bilenchi. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        refreshNavigationControls()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    // MARK: Button press handlers
    
    @IBAction func handleReturnPress(_ sender: UITextField) {
        guard let text = sender.text, let url = URL.httpURL(withString: text) else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    @IBAction func handleBackButtonPress(_ sender: UIBarButtonItem) {
        webView.stopLoading()
        webView.goBack()
    }
    
    @IBAction func handleForwardButtonPress(_ sender: UIBarButtonItem) {
        webView.stopLoading()
        webView.goForward()
    }
    
    @IBAction func handleRefreshButtonPress(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    // MARK: Private methods
    
    private func refreshNavigationControls() {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        refreshButton.isEnabled = webView.url != nil
    }
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        refreshNavigationControls()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        textField.text = webView.url?.absoluteString
    }
}
