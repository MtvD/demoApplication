//
//  DetailViewController.swift
//  demoApplication
//
//  Created by Macbook  on 8/22/20.
//  Copyright © 2020 mtvd. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imgView: AsyncImageView!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var txtView: UITextView!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let article = self.article {
            imgView.loadImgUsingUrlString(urlString: article.urlToImage ?? "")
            linkButton.setTitle(article.url, for: .normal)
            linkButton.addTarget(self, action: #selector(didTapLink), for: .touchUpInside)
            txtView.text = article.content?.htmlToString
        }
    }
    
    @objc func didTapLink() {
        guard
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "webViewVc") as? WebViewController,
        let article = article
        else { return }
        
        vc.url = URL(string: article.url ?? "")
        vc.contentHTML = article.content ?? ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
