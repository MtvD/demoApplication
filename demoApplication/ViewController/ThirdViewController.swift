//
//  ThirdViewController.swift
//  demoApplication
//
//  Created by Macbook  on 8/19/20.
//  Copyright © 2020 mtvd. All rights reserved.
//

import UIKit
import CoreData

class ThirdViewController: UIViewController {
    @IBOutlet weak var nameView: CustomView!
    @IBOutlet weak var passView: CustomView!
    @IBOutlet weak var txtView: UITextView!
    
    let API_KEY = "4c78908e21b24d84bc56cb462d3e4424"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameView.contentTxt.text = ""
        passView.contentTxt.text = ""
        txtView.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        self.deleteData()
    }
    
    func initView() {
        nameView.titleLbl.text = "Name"
        passView.titleLbl.text = "Password"
        passView.contentTxt.isSecureTextEntry = true
    }
    
    fileprivate func save() {
        if let user = nameView.contentTxt.text, let pass = passView.contentTxt.text {
            UserDefaults.standard.setValue(user, forKey: "user_name")
            UserDefaults.standard.setValue(pass, forKey: "password")
        }
        
        UserDefaults.standard.setValue(API_KEY, forKey: "api_token")
        UserDefaults.standard.synchronize()
    }
    
    fileprivate func retrieve() {
        if
            let user = UserDefaults.standard.value(forKey: "user_name") as? String, !user.isEmpty,
            let pass = UserDefaults.standard.value(forKey: "password") as? String, !pass.isEmpty,
            let token = UserDefaults.standard.value(forKey: "api_token") as? String, !token.isEmpty {
            txtView.text =
                "User name: \(user)" + "\n" +
                "Password: \(pass)" + "\n" +
            "Token: \(token)"
        }
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        //        save()
        saveData()
    }
    
    @IBAction func didTapGetText(_ sender: Any) {
        self.view.endEditing(true)
        //        retrieve()
        retrieveData()
    }
    
    func saveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        if #available(iOS 13.0, *) {
            let managedContext = appDelegate.persistentContainer.viewContext
            guard
                let name = self.nameView.contentTxt.text,
                let pass = self.passView.contentTxt.text,
                !name.isEmpty,
                !pass.isEmpty
                else { return }
            
            
            let user = UserData(context: managedContext)
            user.username = name
            user.password = pass
            user.token = API_KEY
            do {
                try managedContext.save()
                print("Saved!")
            } catch let error as NSError {
                print("Could not save - \(error) - \(error.userInfo)")
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func retrieveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        if #available(iOS 13.0, *) {
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
            
            do {
                let data = try managedContext.fetch(fetchRequest)
                var userList: [UserModel] = []
                
                for item in data {
                    if let item = item as? UserModel {
                        userList.append(item)
                    }
                }
                
                txtView.text =
                    "User name: \(userList.last?.username ?? "---")" + "\n" +
                    "Password: \(userList.last?.password ?? "---")" + "\n" +
                "Token: \(userList.last?.token ?? "---")"
            } catch {
                print("Failed")
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    func deleteData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        
        if let result = try? managedContext.fetch(fetchRequest) {
            for object in result {
                managedContext.delete(object as! NSManagedObject)
            }
            
            do {
                try managedContext.save()
            } catch {
                // Do something... fatalerror
            }
        }
    }
}
