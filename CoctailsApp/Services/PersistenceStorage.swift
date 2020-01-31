//
//  DataManager.swift
//  CoctailsApp
//
//  Created by Artur Sokolov on 30.01.2020.
//  Copyright © 2020 Artur Sokolov. All rights reserved.
//

import RealmSwift

final class PersistenceStorage {
    // MARK: - Private Properties
    private let realm = try! Realm()
    
    // MARK: - Public Methods
    func save(_ object: Object) {
        try! realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    func delete(_ object: Object) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func fetchObject<T: Object>(ofType type: T.Type, key: String) -> T? {
        return realm.object(ofType: type.self, forPrimaryKey: key)
    }
    
    func containsObject<T: Object>(ofType type: T.Type, key: String) -> Bool {
        return fetchObject(ofType: type, key: key) == nil ? false : true
    }
    
    func objects<T: Object>(ofType type: T.Type) -> Results<T> {
        return realm.objects(type.self)
    }
}
