//
//  SecondViewController.swift
//  demoApplication
//
//  Created by Macbook  on 8/19/20.
//  Copyright © 2020 mtvd. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var chooseLbl: UILabel!
    @IBOutlet weak var chooseTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = FirstApiViewModel()
    var articles: [Article] = []
    let titles = ["bitcoin", "apple", "earthquake", "animal"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.getCustomLink(str: titles.first ?? "")
        
        chooseLbl.text = "Please select type to view!"
        chooseTableView.delegate = self
        chooseTableView.dataSource = self
        chooseTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    }
}

extension SecondViewController: ViewModelDelegate {
    func submitSuccess(response: Any) {
        if let data = response as? ApiModel, data.articles.count > 0 {
            self.articles = data.articles
            self.chooseTableView.reloadData()
            self.tableView.reloadData()
        }
    }
    
    func submitFail(response: String) {
        print(response)
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case self.chooseTableView:
            return 60
        case self.tableView:
            return 120
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.chooseTableView:
            return self.titles.count
        case self.tableView:
            return self.articles.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case self.chooseTableView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell {
                cell.titleLbl.text = titles[indexPath.row]
                cell.imageView?.isHidden = true
                cell.contentLbl.isHidden = true
                return cell
            }
        case self.tableView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell {
                cell.data = self.articles[indexPath.row]
                return cell
            }
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case self.chooseTableView:
            viewModel.getCustomLink(str: titles[indexPath.row])
            self.tableView.reloadData()
        case self.tableView:
            break
        default:
            break
        }
    }
}


