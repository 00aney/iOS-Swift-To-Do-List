//
//  AddViewController.swift
//  First My To Do List App
//
//  Created by 김태동 on 2017. 1. 10..
//  Copyright © 2017년 00aney. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var todoItem: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var dueDate:NSDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //137,203,240
        navigationController?.navigationBar.tintColor = UIColor(red: 137.0/255, green: 203.0/255, blue: 240.0/255, alpha: 1.0)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(AddViewController.saveButton_click))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveButton_click(){
        CoreDataManager.save(todoItem: todoItem.text!, dueDate: dueDate, complete: false)
        todoItem.text = ""
        UIView.transition(with: todoItem, duration: 0.2, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.todoItem.layer.backgroundColor = UIColor.green.cgColor
            }, completion: {
                (value:Bool) in 
                
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func datePicker_changed(_ sender: AnyObject) {
        dueDate = dueDatePicker.date as NSDate
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
