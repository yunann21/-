//
//  StorageManager.swift
//  Должник
//
//  Created by Егор Аблогин on 17.02.2024.
//

import Foundation
import RealmSwift

final class StorageManager {
    static let shared = StorageManager()
    
    private let realm: Realm
    
    // MARK: - initializers
    
    private init() {
        let config = Realm.Configuration(
            schemaVersion: 2)
        
        Realm.Configuration.defaultConfiguration = config
        
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    // MARK: - CRUD
    /**
     Получить данные из бд
     */
    // MARK: fetch
    func fetchData<T>(_ type: T.Type) -> Results<T> where T: RealmFetchable {
        realm.objects(T.self)
    }
    // MARK: add
    func add(
        personName: String,
        debtSize: Int,
        direction: Bool,
        startDate: Date,
        finishDate: Date,
        comment: String = "",
        completion: (Debts) -> Void
    ) {
        write {
            let newDebt = Debts(
                personName: personName,
                debtSize: debtSize,
                direction: direction,
                startDate: startDate,
                finishDate: finishDate,
                comment: comment
            )
            realm.add(newDebt)
            completion(newDebt)
        }
    }
    
    // MARK: delete
    func delete(_ debt: Debts) {
        write {
            realm.delete(debt)
        }
    }
    
    // MARK: edit
    func edit(_ debt: Debts, personName: String, debtSize: Int, direction: Bool, startDate: Date, finishDate: Date, comment: String) {
        write {
            debt.personName = personName
            debt.debtSize = debtSize
            debt.direction = direction
            debt.startDate = startDate
            debt.finishDate = finishDate
            debt.comment = comment
        }
    }
    
    func toggleIsPayed(_ debt: Debts) {
        write {
            debt.isPayed = !debt.isPayed
        }
    }
    
    // MARK: write
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
}
