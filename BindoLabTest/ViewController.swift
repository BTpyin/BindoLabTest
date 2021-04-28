//
//  ViewController.swift
//  BindoLabTest
//
//  Created by Bowie Tso on 25/4/2021.
//

import UIKit
import RealmSwift
import RxRealm
import RxSwift
import RxCocoa

class ViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var fullScreenSize :CGSize!
    var viewModel: ViewModel?
    var disposeBag = DisposeBag()


    @IBOutlet weak var chefCollectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var pizzaBottomView: UIView!
    @IBOutlet weak var chefCollectionView: UICollectionView!
    @IBOutlet weak var add10PizzaButton: UIButton!
    @IBOutlet weak var add100PizzaButton: UIButton!
    @IBOutlet weak var factoryMainSwitch: UISwitch!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModel()
        chefCollectionView.delegate = self
        chefCollectionView.dataSource = self
        fullScreenSize =
            UIScreen.main.bounds.size
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        }
        else {
            print("First launch, setting NSUserDefault.")
            SyncData().add1000PizzaRecord{[weak self] (failReason) in
                if let tempWeather = try? Realm().objects(Pizza.self){
                    SyncData().create7Chef{[weak self] (failReason) in
                        if let tempChef = try? Realm().objects(Chef.self){
                            

                        }else{
                            self?.showErrorAlert(reason: failReason, showCache: true, okClicked: nil)

                           }
                          print(failReason)
                    }

                }else{
                    self?.showErrorAlert(reason: failReason, showCache: true, okClicked: nil)

                   }
                  print(failReason)
            }
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        Observable.changeset(from: (viewModel?.chefList)!).subscribe(onNext: { results in
            print(self.viewModel?.chefList)
            self.chefCollectionView.reloadData()
        }).disposed(by: disposeBag)
        
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
            
            return CGSize(width: (UIScreen.main.bounds.size.width)/7, height: 594)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.chefList?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "ChefCollectionViewCell"
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ChefCollectionViewCell else {
          fatalError("The dequeued cell is not an instance of ChefCollectionViewCell.")
        }
        cell.uiBind(chef: (viewModel?.chefList?[indexPath.row])!)
        return cell
    }
    

    
    
}

class ViewModel{
    var chefList : Results<Chef>?
    var pizzaList: Results<Pizza>?
    private var timer: DispatchSourceTimer?
    
    init(){
        chefList = try? Realm().objects(Chef.self)
    }
    
    func startTimer() {
        let queue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".timer")
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer!.schedule(deadline: .now(), repeating: .seconds(1))
        timer!.setEventHandler { [weak self] in
            // do whatever stuff you want on the background queue here here


            DispatchQueue.main.async {
                // update your model objects and/or UI here
            }
        }
        timer!.resume()
    }

    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
}

