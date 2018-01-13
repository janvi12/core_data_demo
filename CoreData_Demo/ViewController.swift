//
//  ViewController.swift
//  CoreData_Demo
//
//  Created by Harshul Shah on 08/01/18.
//  Copyright © 2018 Harsh Mistry. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController
{
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtPassWord: UITextField!
    @IBOutlet var txtSearch: UITextField!    
    @IBOutlet var lblSearch: UILabel!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnInsert(_ sender: UIButton)
    {
        if txtUserName.text != "" && txtPassWord.text != ""
        {
            let newUser = NSEntityDescription.entity(forEntityName: "Student", in: context)
            
            let person = NSManagedObject(entity: newUser!, insertInto: context)
            
            //print(newUser!)
            
            person.setValue(txtPassWord.text, forKey: "password")
            person.setValue(txtUserName.text, forKey: "username")
            
            do
            {
                try context.save()
            }
            catch
            {
                print(error)
            }
            txtUserName.text = ""
            txtPassWord.text = ""
        }
            
        else
        {
            let alert = UIAlertController(title: "Welcome", message: "Please Fill the Information", preferredStyle: .alert)
            
            let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okBtn)
            
            let cancelBtn = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            alert.addAction(cancelBtn)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnSearch(_ sender: UIButton)
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        let searchString = self.txtSearch.text
        request.predicate = NSPredicate(format: "username == %@", searchString!)
        
        do{
            let result = try context.fetch(request)
            
            if result.count > 0
            {
                let uname = (result[0] as AnyObject).value(forKey: "username") as! String
                //let pwd = (result[0] as AnyObject).value(forKey: "password") as! String
                
                self.lblSearch.text = uname
            }
            else{
                lblSearch.text = "Result is not found..."
            }
        }
        catch{
            print(error)
        }
        txtSearch.text = ""
    }
    
    @IBAction func btnView(_ sender: UIButton)
    {
        let next = storyboard?.instantiateViewController(withIdentifier: "sec") as! SecondViewController
        navigationController?.pushViewController(next, animated: true)
    }
}
