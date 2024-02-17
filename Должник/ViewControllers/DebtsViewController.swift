//
//  ViewController.swift
//  Должник
//
//  Created by Anna Ablogina on 14.02.2024.
//

import UIKit
import RealmSwift

final class DebtsViewController: UITableViewController {
    private let storageManager = StorageManager.shared
    private var debts: Results<Debts>!

    override func viewDidLoad() {
        super.viewDidLoad()
        debts = storageManager.fetchData(Debts.self)
        storageManager.save()
        
    }


}

