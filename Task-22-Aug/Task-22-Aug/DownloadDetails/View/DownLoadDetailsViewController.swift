//
//  DownLoadDetailsViewController.swift
//  Task-21-Aug
//
//  Created by Mac on 21/08/23.
//

import UIKit



class DownLoadDetailsViewController: UIViewController {
    
    private enum CollectionViewCellIndex: Int {
        case profileCell = 0
        case secondCell = 1
        case thirdCell = 2
    }
    
    private enum collectionViewConstantValue:Int {
        case numberOfItem = 3
        case changeButtonTitle = 2
    }
    
    @IBOutlet weak var playCollection: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXibs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    private func registerXibs() {
        let nibName = UINib(nibName: "ProfileCollectionViewCell", bundle: nil)
        playCollection.register(nibName, forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        let nibNameOne = UINib(nibName: "SecondCollectionViewCell", bundle: nil)
        playCollection.register(nibNameOne, forCellWithReuseIdentifier: "SecondCollectionViewCell")
        let nibNameTwo = UINib(nibName: "ThirdCollectionViewCell", bundle: nil)
        playCollection.register(nibNameTwo, forCellWithReuseIdentifier: "ThirdCollectionViewCell")
    }
    
    
    @IBAction func viewTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func downloadAndScrollButton(_ sender: Any) {
        let visibleItems: NSArray = self.playCollection.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        
        if nextItem.row < collectionViewConstantValue.numberOfItem.rawValue {
            self.playCollection.scrollToItem(at: nextItem, at: .left, animated: true)
            if nextItem.row == collectionViewConstantValue.changeButtonTitle.rawValue {
                self.nextButton.setTitle("Confirm", for: .normal)
                
                self.nextButton.setTitleColor(.red, for: .normal)
            }
        }
    }
    
}

extension DownLoadDetailsViewController: UICollectionViewDelegate,
                                         UICollectionViewDataSource,
                                         UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewConstantValue.numberOfItem.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = CollectionViewCellIndex(rawValue: indexPath.row)
        
        switch index {
        case .profileCell:
            guard let profileCell = playCollection.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell else {return UICollectionViewCell()}
            return profileCell
        case .secondCell:
            guard let oneCell = playCollection.dequeueReusableCell(withReuseIdentifier: "SecondCollectionViewCell", for: indexPath) as? SecondCollectionViewCell else {return UICollectionViewCell()}
            return oneCell
        case .thirdCell:
            guard let twoCell = playCollection.dequeueReusableCell(withReuseIdentifier: "ThirdCollectionViewCell", for: indexPath) as? ThirdCollectionViewCell else {return UICollectionViewCell()}
            return twoCell
        case .none:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.size.width,
            height: collectionView.frame.size.height
        )
    }
    
}
