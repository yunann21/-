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
            let debt = Debts(personName: "qwe", debtSize: 123, direction: true, startDate: Date(), finishDate: Date())
            realm.add(debt)
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
