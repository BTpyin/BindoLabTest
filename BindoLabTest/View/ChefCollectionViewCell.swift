//
//  ChefCollectionViewCell.swift
//  BindoLabTest
//
//  Created by Bowie Tso on 25/4/2021.
//

import UIKit

class ChefCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {

    var cellChef: Chef?
    
    @IBOutlet weak var chefImageView: UIImageView!
    @IBOutlet weak var chefSwitch: UISwitch!
    @IBOutlet weak var pizzaTableView: UITableView!
    
    @IBOutlet weak var chefNameLabel: UILabel!
    @IBOutlet weak var chefRemainingLabel: UILabel!
    @IBOutlet weak var chefRateLabel: UILabel!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellChef?.pizzaList.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PizzaTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PizzaTableViewCell else {
          fatalError("The dequeued cell is not an instance of PizzaTableViewCell.")
        }
        cell.rowNum = indexPath.row
        cell.uiBind(pizza: cellChef?.pizzaList[indexPath.row] ?? Pizza())
        return cell
    }
    
    func uiBind(chef: Chef){
        cellChef = chef
        chefNameLabel.text = "Pizza Chef \((chef.chefId)!)"
        chefRemainingLabel.text = "Remaining pizza: \(chef.remainingPizza)"
        chefRateLabel.text = "\(chef.rate) second per pizza"
        pizzaTableView.reloadData()
    }
    
}
