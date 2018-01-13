//
//  UpdateViewController.swift
//  CoreData_Demo
//
//  Created by Harshul Shah on 09/01/18.
//  Copyright © 2018 Harsh Mistry. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController
{
    var uname = ""
    var pwd  = ""
    
    @IBOutlet var unametxt: UITextField!
    
    @IBOutlet var pwdtxt: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        unametxt.text = uname
        pwdtxt.text = pwd
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnUpdate(_ sender: UIButton)
    {
       
    }
}
