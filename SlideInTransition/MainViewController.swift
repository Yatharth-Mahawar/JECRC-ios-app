//
//  ViewController.swift
//  SlideInTransition
//
//  Created by Tushar on 25/09/19.
//  Copyright © 2019 Tushar. All rights reserved.
//

import UIKit
import WebKit

class MainViewController: UIViewController,WKNavigationDelegate {
    
    let transition = SlideInTransition()
    var topView: UIView?
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://jecrcuniversity.edu.in/")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    
  
    
    @IBAction func didSelectedMenuItem(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        viewController.didMenuTapped = { menuType in
            print(menuType)
            
            self.transitionToMainView(menuType)
        }
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.transitioningDelegate = self
        present(viewController, animated: true)
    }
    
    func transitionToMainView(_ menuType: MenuType) {
        let title = String(describing: menuType)
        self.title = title
        topView?.removeFromSuperview()
        switch menuType {
        case .Home:
            print(String(describing: menuType))
            let view = webView!
            let url = URL(string: "https://jecrcuniversity.edu.in/")!
            view.load(URLRequest(url: url))
            view.allowsBackForwardNavigationGestures = true
            
        case .ErpLogin:
            let view = webView!
            let url = URL(string: "http://sws.jecrcuniversity.edu.in/parentlogin/")!
            view.load(URLRequest(url: url))
            view.allowsBackForwardNavigationGestures = true
            
            
        case .Result:
            let view = webView!
            let url = URL(string: "http://sws.jecrcuniversity.edu.in/result/")!
            view.load(URLRequest(url: url))
            view.allowsBackForwardNavigationGestures = true
            

        }
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
