//
//  ViewController.swift
//  webframer
//
//  Created by Price, Joseph on 6/10/15.
//  Copyright (c) 2015 Price, Joseph. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {

    var url: NSURL?
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    var webView: WKWebView?
    
    override func loadView() {
        super.loadView()
        
        self.webView = WKWebView(frame: view.bounds)

        NSLog("got \(Process.arguments.count) arguments \(Process.arguments)")
        
        if Process.arguments.count == 3 {
            for (i, arg) in enumerate(Process.arguments) {
                if arg == "--url" {
                    var urlString = Process.arguments[i + 1]
                    if !(urlString.hasPrefix("http://") || urlString.hasPrefix("https://")) {
                        urlString = "http://" + urlString
                    }
                    url = NSURL(string: urlString)
                }
            }
        }
            
        NSLog("got url \(url)")
        
        self.view = self.webView!
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if self.view.window != nil && url != nil {
            self.view.window!.title = url!.absoluteString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if url != nil {
            let req = NSURLRequest(URL: url!)
            self.webView!.loadRequest(req)
        }
 
    }

}

