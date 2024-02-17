//
//  Delegates.swift
//  Должник
//
//  Created by Егор Аблогин on 17.02.2024.
//

import Foundation

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
