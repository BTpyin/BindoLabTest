//
//  SyncDataToRealm.swift
//  BindoLabTest
//
//  Created by Bowie Tso on 28/4/2021.
//

import Foundation
import RealmSwift
import ObjectMapper

enum SyncDataFailReason: Error {
  case network
  case realmWrite
  case other
}


class SyncData {
    static var firstSync : Bool  = false
    
    static var realmBackgroundQueue = DispatchQueue(label: ".realm", qos: .background)
    
    static func writeRealmAsync(_ write: @escaping (_ realm: Realm) -> Void,
                                completed: (() -> Void)? = nil) {
      SyncData.realmBackgroundQueue.async {
        autoreleasepool {
          do {
            let realm = try Realm()
            realm.beginWrite()
            write(realm)
            try realm.commitWrite()

            if let completed = completed {
              DispatchQueue.main.async {
                let mainThreadRealm = try? Realm()
                mainThreadRealm?.refresh() // Get updateds from Background thread
                completed()
              }
            }
      } catch {
            print("writeRealmAsync Exception \(error)")
          }
        }
      }
    }
    
    func failReason(error: Error?, resposne: Any?) -> SyncDataFailReason {
      if let error = error as NSError?, error.domain == NSURLErrorDomain {
        return .network
      }
      return .other
    }
    
    func add1000PizzaRecord(completed:((SyncDataFailReason?) -> Void)?){
        SyncData.writeRealmAsync({ (realm) in
            for i in 1...100 {
                realm.add(Pizza().createPizza(code: i))
            }
            
        }, completed:{
            completed?(nil)
          })
    }
    
    func create7Chef(completed:((SyncDataFailReason?) -> Void)?){
        SyncData.writeRealmAsync({ (realm) in
            
            for i in 1...7 {
                realm.add(Chef().createChef(code: i))
            }
            var index = 1
            for pizza in realm.objects(Pizza.self){
                realm.object(ofType: Chef.self, forPrimaryKey: "\(index)")?.assignPizza(pizzas: pizza)
                index+=1
                if index > 7{
                    index = 1
                }
                
            }
            for i in 1...7 {
                realm.object(ofType: Chef.self, forPrimaryKey: "\(i)")?.remainingPizza = realm.object(ofType: Chef.self, forPrimaryKey: "\(i)")?.pizzaList.count ?? 0
                realm.object(ofType: Chef.self, forPrimaryKey: "\(i)")?.rate = i
            }
        }, completed:{
            completed?(nil)
          })
    }
    
    
    
}
