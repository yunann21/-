//
//  SettingsViewController.swift
//  Должник
//
//  Created by Егор Аблогин on 18.02.2024.
//

import UIKit

class AboutAppViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    
    private var infoText: String {
        """
        Здесь будет располагаться информация о приложении.
        В данный момент мы не располагаем информацией о том кто
        и когда написал данное приложение. Точная информация появится позднее.
        """
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoLabel.text = infoText
        
    }
    @IBAction func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
