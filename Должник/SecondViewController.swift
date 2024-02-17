//
//  SecondViewController.swift
//  Должник
//
//  Created by Anna Ablogina on 14.02.2024.
//

import UIKit


final class SecondViewController: UIViewController {

    @IBOutlet var name: UITextField!
    @IBOutlet var amount: UITextField!
    
    @IBOutlet var startDate: UIDatePicker!
    @IBOutlet var finalDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func deleteInformation() {
        name.text = ""
        amount.text = ""
        startDate.date = .now
        finalDate.date = .now
    }
    
    
    @IBAction func saveInformation(_ sender: UIButton) {
        if name.text!.isEmpty || amount.text!.isEmpty {
            showAlert(withTitle: "Ошибка", andMessage: "Не указано имя и/или сумма")
        }
        if finalDate.date < startDate.date {
            showAlert(withTitle: "Ошибка", andMessage: "Дата возврата не может быть раньше стартовой даты")
        }
    
        let namePattern = "^[a-zA-Zа-яА-я ]{2,50}$"
        let isNameValid = NSPredicate(format: "SELF MATCHES %@", namePattern).evaluate(with: name.text)
        if !isNameValid {
            showAlert(withTitle: "Ошибка", andMessage: "Имя указано некорректно")
        }
        
    }
    


}
