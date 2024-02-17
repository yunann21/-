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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newDebtVC = segue.destination as? NewDebtViewController
        newDebtVC?.delegate = self
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

// MARK: - UITableViewDelegate
extension DebtsViewController {
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let debt = debts[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] _, _, _ in
            storageManager.delete(debt)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - NewDebtViewControllerDelegate
extension DebtsViewController: NewDebtViewControllerDelegate {
    func addDebt(personName: String, debtSize: Int, direction: Bool, startDate: Date, finishDate: Date, comment: String) {
        storageManager.save(personName: personName,
                             debtSize: debtSize,
                             direction: direction,
                             startDate: startDate,
                            finishDate: finishDate) { debt in
            let rowIndex = IndexPath(row: debts.index(of: debt) ?? 0, section: 0)
            tableView.insertRows(at: [rowIndex], with: .automatic)
        }
    }
}
