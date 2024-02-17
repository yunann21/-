//
//  ViewController.swift
//  Должник
//
//  Created by Anna Ablogina on 14.02.2024.
//

import UIKit
import RealmSwift

protocol NewDebtViewControllerDelegate: AnyObject {
    func addDebt(
        personName: String,
        debtSize: Int,
        direction: Bool,
        startDate: Date,
        finishDate: Date,
        comment: String
    )
}

final class DebtsViewController: UITableViewController {
    private let storageManager = StorageManager.shared
    private var debts: Results<Debts>!

    override func viewDidLoad() {
        super.viewDidLoad()
        debts = storageManager.fetchData(Debts.self)
        storageManager.save()
    }
}

// MARK: - UITableViewDataSource
extension DebtsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        debts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Debt", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        let debt = debts[indexPath.row]
        
        content.text = debt.personName
        content.secondaryText = debt.debtSize.description
        content.secondaryTextProperties.color = debt.direction ? .green : .red
        
        cell.contentConfiguration = content
        
        return cell
    }
}

// MARK: - NewDebtViewControllerDelegate
extension DebtsViewController: NewDebtViewControllerDelegate {
    func addDebt(personName: String, debtSize: Int, direction: Bool, startDate: Date, finishDate: Date, comment: String) {
        print("add debt")
    }
}
