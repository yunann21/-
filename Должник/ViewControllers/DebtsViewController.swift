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
    
    private var currentDebts: Results<Debts>!
    private var payedDebts: Results<Debts>!

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        debts = storageManager.fetchData(Debts.self)
        
        currentDebts = debts.filter("isPayed = false")
        payedDebts = debts.filter("isPayed = true")
        reloadBadge()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newDebtVC = segue.destination as? NewDebtViewController
        newDebtVC?.delegate = self
    }
    
    private func reloadBadge() {
        if let tabBarItem = navigationController?.tabBarItem {
            tabBarItem.badgeValue = currentDebts.count.description
        }
    }
}

// MARK: - UITableViewDataSource
extension DebtsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "Текущие долги" : "Выплачено"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? currentDebts.count : payedDebts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Debt", for: indexPath)
        
        guard let debtCell = cell as? DebtCell else { return UITableViewCell() }
     
        let debt = indexPath.section == 0 ? currentDebts[indexPath.row] : payedDebts[indexPath.row]
        
        debtCell.personNameLabel.text = debt.personName
        debtCell.debtSizeLabel.text = debt.debtSize.description
        debtCell.hasCommentImage.isHidden = debt.comment.isEmpty
        debtCell.dates.forEach { dateLabel in
            if dateLabel.accessibilityIdentifier == "dateStart" {
                dateLabel.text = debt.startDate.formatted(date: .numeric, time: .omitted)
            } else {
                dateLabel.text = debt.finishDate.formatted(date: .numeric, time: .omitted)
            }
        }
        debtCell.debtSizeLabel.textColor = debt.direction ? .green : .red
        debtCell.debtDirectionImage.image = debt.direction 
            ? UIImage(systemName: "arrowshape.up.fill")
            : UIImage(systemName: "arrowshape.down.fill")
        debtCell.debtDirectionImage.tintColor = debt.direction ? .green : .red
        
        return debtCell
    }
    
    
    
}

// MARK: - UITableViewDelegate
extension DebtsViewController {
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let debt = indexPath.section == 0 ? currentDebts[indexPath.row] : payedDebts[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] _, _, _ in
            storageManager.delete(debt)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            reloadBadge()
        }
        
        let toggleActionTitle = indexPath.section == 0 ? "Выплачено" : "Еще должен"
        
        let toggleAction = UIContextualAction(style: .normal, title: toggleActionTitle) { [unowned self] _, _, isDone in
            let fromIndex = indexPath
            let section = debt.isPayed ? 0 : 1
            let toIndex = IndexPath(
                row: debt.isPayed ? currentDebts.count : payedDebts.count,
                section: section)
            
            storageManager.toggleIsPayed(debt)
            tableView.moveRow(at: fromIndex, to: toIndex)
            reloadBadge()
            isDone(true)
        }
        
        toggleAction.backgroundColor = indexPath.section == 0 ? .green : .brown
        
        return UISwipeActionsConfiguration(actions: [toggleAction, deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = indexPath.section == 0 
            ? currentDebts[indexPath.row].comment
            : payedDebts[indexPath.row].comment
        
        if !comment.isEmpty {
            let alert = AlertControllerBuilder(title: "Комментарий", message: comment)
            alert.addAction(title: "OK", style: .default)
            present(alert.build(), animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - NewDebtViewControllerDelegate
extension DebtsViewController: NewDebtViewControllerDelegate {
    func addDebt(personName: String, debtSize: Int, direction: Bool, startDate: Date, finishDate: Date, comment: String) {
        storageManager.add(personName: personName,
                             debtSize: debtSize,
                             direction: direction,
                             startDate: startDate,
                            finishDate: finishDate,
                            comment: comment) { debt in
            let rowIndex = IndexPath(row: currentDebts.index(of: debt) ?? 0, section: 0)
            tableView.insertRows(at: [rowIndex], with: .automatic)
            reloadBadge()
        }
    }
}
