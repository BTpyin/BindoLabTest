//
//  ModifierView.swift
//  BindoLabTest
//
//  Created by Bowie Tso on 28/4/2021.
//

import UIKit

class ModifierView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row != 6){
            let cellIdentifier = "ToppingCollectionViewCell"
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ToppingCollectionViewCell else {
              fatalError("The dequeued cell is not an instance of ToppingCollectionViewCell.")
            }
            return cell
        }else{
            let cellIdentifier = "MoreToppingCollectionViewCell"
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MoreToppingCollectionViewCell else {
              fatalError("The dequeued cell is not an instance of MoreToppingCollectionViewCell.")
            }
            return cell
        }

    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
