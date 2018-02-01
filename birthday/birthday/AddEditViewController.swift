//
//  AddEditViewController.swift
//  birthday
//
//  Created by Maria Teresa Rojo on 1/31/18.
//  Copyright © 2018 Maria Rojo. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var giftsTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: AddBirthdayDelegate?
    var indexPath: IndexPath?
    
    var name: String?
    var gifts: String?
    var date: Date?
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        delegate?.save(self, with: nameTextField.text!, gifts: giftsTextField.text!, and: datePicker.date, at: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = name
        giftsTextField.text = gifts
        if date != nil {
            datePicker.date = date!
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
