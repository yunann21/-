//
//  Debts.swift
//  Должник
//
//  Created by Егор Аблогин on 17.02.2024.
//

import RealmSwift
import Foundation

final class Debts: Object {
    @Persisted var personName: String
    @Persisted var debtSize: Int
    @Persisted var startDate: Date
    @Persisted var finishDate: Date
    @Persisted var comment: String
    
    convenience init(personName: String, debtSize: Int, startDate: Date, finishDate: Date, comment: String = "") {
        self.init()
        self.personName = personName
        self.debtSize = debtSize
        self.startDate = startDate
        self.finishDate = finishDate
        self.comment = comment
    }
}


