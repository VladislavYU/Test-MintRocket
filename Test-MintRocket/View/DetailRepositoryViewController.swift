//
//  DetailRepositoryViewController.swift
//  Test-MintRocket
//
//  Created by Vladislav Zakharchenko on 13.09.2018.
//  Copyright © 2018 Vladislav Zakharchenko. All rights reserved.
//

import UIKit

class DetailRepositoryViewController: UIViewController, UIWebViewDelegate {

    var repository: RepositoryModel!
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    let webView: UIWebView = {
        let view = UIWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLaoyt()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        
        webView.delegate = self
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        webView.loadRequest(URLRequest(url: URL(string: repository.htmlUrl)!))
//        Api.shared.getRepository(name: repository.fullName) { (data) in
//            let str = String(data: data, encoding: .utf8)!
//
//            self.webView.loadHTMLString(str, baseURL: nil)
//            self.activityIndicator.stopAnimating()
//        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupLaoyt(){
        view.addSubview(webView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
            ])
    }
    
    @objc private func share(){
        let link = repository.htmlUrl
        let activity = UIActivityViewController(activityItems: [link], applicationActivities: nil)
        activity.popoverPresentationController?.sourceView = self.view
        self.present(activity, animated: true, completion: nil)
    }

}
