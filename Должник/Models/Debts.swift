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
    @Persisted var direction: Bool
    @Persisted var startDate: Date
    @Persisted var finishDate: Date
    @Persisted var comment: String
    @Persisted var isPayed: Bool = false
    
    convenience init(personName: String, debtSize: Int, direction: Bool, startDate: Date, finishDate: Date, comment: String = "", isPayed: Bool = false) {
        self.init()
        self.personName = personName
        self.debtSize = debtSize
        self.direction = direction
        self.startDate = startDate
        self.finishDate = finishDate
        self.comment = comment
        self.isPayed = isPayed
    }
}


