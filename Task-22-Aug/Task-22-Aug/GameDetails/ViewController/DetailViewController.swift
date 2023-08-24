//
//  DetailViewController.swift
//  Task-21-Aug
//
//  Created by Mac on 21/08/23.
//

import UIKit

enum CommonNilCoalesingValue:CGFloat {
    case commonValue = 00
}

class DetailViewController: UIViewController {
    
    private enum CollectionViewConstantValue:Int {
        case flowLayoutConstantValue = 10
        case collectionViewIndex = 7
    }
    
    // MARK: @IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnCancelDownload: UIButton!
    
    // MARK: Animation Controls @IBOutlets
    @IBOutlet weak var DownloadButtonContainer: UIView!
    @IBOutlet weak var progressViewWidhtConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnNextHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnNextWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var downloadBtnStackView: UIStackView!
    
    // MARK: Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        designView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //In order show animation of scrolling of collection view afetr screen is fully visible, below animation code is added in viewDidAppear
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.collectionView.contentInset = .zero
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    // MARK: Private functions
    private func designView() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: view.frame.size.width / 2, bottom: 0, right: 0)
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "CollectionViewCell")
        
    }
    
    // MARK: @IBAction
    @IBAction func downloadActivityButton(_ sender: Any) {
        startDownloading()
    }
    
    @IBAction func nextButtonAfterDownload(_ sender: Any) {
        guard let detailDownloadViewController = storyboard?.instantiateViewController(withIdentifier: "DownLoadDetailsViewController") as? DownLoadDetailsViewController else {
            return
        }
        detailDownloadViewController.modalPresentationStyle = .overCurrentContext
        present(detailDownloadViewController, animated: true)
    }
    
}


// MARK: Dwownload button and Progress animation
extension DetailViewController {
    private func startDownloading() {
        showCancelDownloadButton()
    }
    
    private func showCancelDownloadButton() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.btnCancelDownload.isHidden = false
            self?.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.showProgress()
        }
    }
    
    private func showProgress() {
        UIView.animate(withDuration: 2) { [weak self] in
            self?.progressViewWidhtConstraint.constant = self?.DownloadButtonContainer.frame.size.width ?? CommonNilCoalesingValue.commonValue.rawValue
            self?.view.layoutIfNeeded()
        } completion: { [weak self]_ in
            self?.showNextBtn()
        }
    }
    
    private func showNextBtn() {
        btnNext.isHidden = false
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.btnNextWidthConstraint.constant = self?.downloadBtnStackView.frame.size.width ?? CommonNilCoalesingValue.commonValue.rawValue
            self?.btnNextHeightConstraint.constant = self?.downloadBtnStackView.frame.size.height ?? CommonNilCoalesingValue.commonValue.rawValue
            self?.view.layoutIfNeeded()
        }
    }
}


extension DetailViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CollectionViewConstantValue.collectionViewIndex.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else {return UICollectionViewCell()}
        collectionViewCell.backgroundColor = .red
        return collectionViewCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width-CGFloat(CollectionViewConstantValue.flowLayoutConstantValue.rawValue))/1.8
        let height = (collectionView.frame.size.height-CGFloat(CollectionViewConstantValue.flowLayoutConstantValue.rawValue))
        return CGSize(width: width, height: height)
    }
}
