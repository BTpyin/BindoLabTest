//
//  Chef.swift
//  BindoLabTest
//
//  Created by Bowie Tso on 28/4/2021.
//

import Foundation
import RealmSwift

class Chef : Object{
    @objc dynamic var chefId: String?
    @objc dynamic var assignedPizza : Int = 0
    @objc dynamic var remainingPizza : Int = 0
    @objc dynamic var rate: Int = 0 // speed per Pizza
    @objc dynamic var chefImageLink : String?
    var pizzaList = List<Pizza>()
    

    
    override static func primaryKey() -> String? {
      return "chefId"
    }
    
    func createChef(code:Int) -> Chef{
        let demoChef = Chef()
        demoChef.chefId = "\(code)"
        return demoChef
    }
    
    func assignPizza(pizzas: Pizza){
        pizzaList.append(pizzas)
    }
    
//    func createChef() -> Chef{
//        var demoChef = Chef()
//
//        return demoChef
//    }
//
}
