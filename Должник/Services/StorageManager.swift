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
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    func fetchData<T>(_ type: T.Type) -> Results<T> where T: RealmFetchable {
        realm.objects(T.self)
    }
    
    func save() {
        write {
           
        }
    }
    
    func save(
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
                finishDate: finishDate
            )
            realm.add(newDebt)
            completion(newDebt)
        }
    }
    
    func delete(_ debt: Debts) {
        write {
            realm.delete(debt)
        }
    }
    
    
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
