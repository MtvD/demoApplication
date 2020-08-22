//
//  ViewController.swift
//  demoApplication
//
//  Created by Macbook  on 8/18/20.
//  Copyright © 2020 mtvd. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = FirstApiViewModel()
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Top Headline News List"
        viewModel.delegate = self
        viewModel.getTopHeadLineList(type: .apiTopHeadLine)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell else {
            return UITableViewCell()
        }
        
        if self.articles.count > 0 {
            cell.data = self.articles[indexPath.row]
        }
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "detailVc") as? DetailViewController
        else { return }
        
        vc.article = articles[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FirstViewController: ViewModelDelegate {
    func submitSuccess(response: Any) {
        if let data = response as? ApiModel, data.articles.count > 0 {
            self.articles = data.articles
            self.tableView.reloadData()
        }
    }
    
    func submitFail(response: String) {
        print(response)
    }
}

