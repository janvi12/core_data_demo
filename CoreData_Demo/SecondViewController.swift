//
//  SecondViewController.swift
//  CoreData_Demo
//
//  Created by Harshul Shah on 08/01/18.
//  Copyright © 2018 Harsh Mistry. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet var tblView: UITableView!
    
    var mainData:[Student] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        
        self.fetchRequest()
        self.tblView.reloadData()
        
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return mainData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let name = mainData[indexPath.row]
        cell.textLabel?.text = name.username! + "  " + name.password!
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete
        {
            let user = mainData[indexPath.row]
            context.delete(user)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do{
                mainData = try context.fetch(Student.fetchRequest())
            }
            catch{
                print(error)
            }
        }
        tblView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let next = storyboard?.instantiateViewController(withIdentifier: "third") as! UpdateViewController
        
        let nameData = mainData[indexPath.row]
        
        next.uname = nameData.username!
        next.pwd = nameData.password!
        
        navigationController?.pushViewController(next, animated: true)
    }
    
    func fetchRequest()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            mainData = try context.fetch(Student.fetchRequest())
        }
        catch{
            print(error)
        }
    }
}
