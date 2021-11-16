//
//  RealmService.swift
//  iMovies
//
//  Created by Miyo on 15/11/21.
//
import RealmSwift

class RealmService {
    static let shared: RealmService = RealmService()
    private init () {
        
    }
    var realm = try! Realm()
    
    func add<T: Object>(_ object: T) {
        do {
            try realm.write{
                realm.add(object)
            }
        }catch {
            handleError(error)
        }
    }
    
    func add<T: Object>(_ objects: [T]) {
        do {
            try realm.write{
                realm.add(objects)
            }
        }catch {
            handleError(error)
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        }catch {
            handleError(error)
        }
    }
    
    func AddOrUpdate<T: Object>(_ object: T) {
        do {
            try realm.write{
                realm.create(T.self, value: object, update: Realm.UpdatePolicy.all)
            }
        }catch {
            handleError(error)
        }
    }
    
    func AddOrUpdate<T: Object>(_ objects: [T]) {
        do {
            try realm.write{
                for item in objects {
                    realm.create(T.self, value: item, update: Realm.UpdatePolicy.all)
                }
            }
        }catch {
            handleError(error)
        }
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write{
                realm.delete(object)
            }
        }catch {
            handleError(error)
        }
    }
    
    func delete<T: Object>(_ objects: [T]) {
        do {
            try realm.write{
                for item in objects {
                    realm.delete(item)
                }
            }
        }catch {
            handleError(error)
        }
    }
    
    private func handleError(_ error: Error) {
        print(error)
    }
}
