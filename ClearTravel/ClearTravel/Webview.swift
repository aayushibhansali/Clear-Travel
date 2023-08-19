//
//  Webview.swift
//  ClearTravel
//

//


import UIKit
import WebKit

class Webview: UIViewController {
    
    @IBOutlet var webview: WKWebView!
    
    var titleString: String!
    var urlString: String!
    
    var url: URL!
    var urlrequest: URLRequest!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = titleString
        url = URL(string: urlString)
        urlrequest = URLRequest(url: url)
        webview.load(urlrequest)
    }

}
