//
//  Pizza.swift
//  BindoLabTest
//
//  Created by Bowie Tso on 28/4/2021.
//

import Foundation
import RealmSwift

class Pizza: Object{
    @objc dynamic var pizzaId : String?
    var modifier = List<Modifier>()
    @objc dynamic var size: Int = 1 // small =0 medium = 1 big =2
    @objc dynamic var finished: Bool = false
    
    
    func createPizza(code:Int) -> Pizza{
        var demo = Pizza()
        demo.pizzaId = "PIZZA_\(code)"
        let originalTopping = ["Roast Beef":true,"Bell Peppers" : true, "Mushrooms" : true, "Onions":true, "Tomatoes":true, "Marinara": true]
        for topping in originalTopping{
            demo.modifier.append(Modifier().createModifier(key: topping.key, value: topping.value))
        }
        return demo
    }
}

class Modifier: Object {
    @objc dynamic var key = ""
    @objc dynamic var modifierValue = true
    
    func createModifier(key : String, value : Bool) -> Modifier{
        var demo = Modifier()
        demo.key = key
        demo.modifierValue = value
        return demo
    }
}
