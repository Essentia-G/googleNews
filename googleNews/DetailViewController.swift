//
//  DetailViewController.swift
//  googleNews
//
//  Created by Станислава on 19.08.2019.
//  Copyright © 2019 Stminchuk. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: PieceOfNews?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = detailItem?.url
        guard let url1 = url else { return }
        
        webView.load(URLRequest(url: url1))
        webView.allowsBackForwardNavigationGestures = true
        
        
        
        /*
        if let url1 = url {
            do {
                let contents = try String(contentsOf: url1)
                let html = """
                \(contents)
                """
                webView.loadHTMLString(html, baseURL: nil)
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
        */

        
        

        /*guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; text-align: justify} </style>
        </head>
        <body>
        <h3>
        \(detailItem.title)
        </h3>
        <h6>
        </h6>
        \(detailItem.content)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil) */
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
