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
    var data: ApiModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        viewModel.getList(type: .api1)
        
        tableView.delegate = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "", bundle: nil), forCellReuseIdentifier: "")
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "") as? NewsCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

extension FirstViewController: ViewModelDelegate {
    func submitSuccess(response: Any) {
        if let data = response as? ApiModel {
            self.data = data
        }
    }
    
    func submitFail(response: String) {
        print(response)
    }
}

