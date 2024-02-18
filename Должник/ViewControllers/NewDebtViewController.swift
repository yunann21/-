//
//  SecondViewController.swift
//  Должник
//
//  Created by Anna Ablogina on 14.02.2024.
//

import UIKit


final class NewDebtViewController: UIViewController {
    
    @IBOutlet var name: UITextField!
    @IBOutlet var amount: UITextField!
    @IBOutlet var comment: UITextField!
    
    @IBOutlet var startDate: UIDatePicker!
    @IBOutlet var finalDate: UIDatePicker!
    
    weak var delegate: NewDebtViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    @IBAction func deleteInformation() {
        name.text = ""
        amount.text = ""
        comment.text = ""
        startDate.date = .now
        finalDate.date = .now
    }
    
    @IBAction func goOut() {
        dismiss(animated: true)
    }
    
    
    @IBAction func saveInformation(_ sender: UIButton) {
        if name.text!.isEmpty || amount.text!.isEmpty {
            showAlert(withTitle: "Ошибка", andMessage: "Не указано имя и/или сумма")
            return
        }
        if finalDate.date < startDate.date {
            showAlert(withTitle: "Внимание!", andMessage: "Дата возврата не может быть раньше стартовой даты.\nСтартовая дата была изменена.") {
                self.startDate.date = self.finalDate.date
                return
            }
        }
        
        let namePattern = "^[a-zA-Zа-яА-я ]{2,50}$"
        let isNameValid = NSPredicate(format: "SELF MATCHES %@", namePattern).evaluate(with: name.text)
        if !isNameValid {
            showAlert(withTitle: "Ошибка", andMessage: "Имя указано некорректно")
            return
        }
        
        let debtSize = Int(amount.text ?? "0") ?? 0
        
        delegate?.addDebt(
            personName: name.text ?? "",
            debtSize: debtSize,
            direction: sender.tag == 1,
            startDate: startDate.date,
            finishDate: finalDate.date,
            comment: comment.text ?? ""
        )
        
        dismiss(animated: true)
        
    }
}
