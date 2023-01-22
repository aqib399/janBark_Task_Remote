//
//  imagesListVC.swift
//  janBark Task
//
//  Created by Aqib Zareen on 21/01/2023.
//

import UIKit
import NVActivityIndicatorView

class imagesListVC: BaseViewController {
    @IBOutlet weak var bottomLoader: NVActivityIndicatorView!
    private var viewModel : ImagesViewModel!
    public var cellViewMdl : cellViewModel!
    @IBOutlet var collectionView: UICollectionView!
    var isRequestInProgress = false
    @IBOutlet weak var loader: NVActivityIndicatorView!
    let collectionViewCellId = "imagesCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingNavigationBar(title: "Free Photos")
        self.registerXib()
        self.showData()
        bottomLoader.isHidden = true
    }
    
}
extension imagesListVC{
    func registerXib()  {
        let nibCell = UINib(nibName: collectionViewCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: collectionViewCellId)
    }
    
    func showData()  {
        self.loader.startAnimating()
        self.viewModel =  ImagesViewModel()
        self.viewModel.bindImagesViewModelToController = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.loader.stopAnimating()
            }
            
        }
    }
    @objc func getMoreImages() {
        
        if let lastItem = items.last, lastItem.nextPage != "" {
            self.viewModel.callFuncToGetImages(pageUrl:items.last?.nextPage ?? "")
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
                self?.bottomLoader.isHidden = true
                self?.bottomLoader.stopAnimating()
                self?.collectionView.reloadData()
            }
        }else{
            print("lastPage")
            self.bottomLoader.isHidden = true
            self.bottomLoader.stopAnimating()
        }
    }
}

//collectionView Delegate DataSource
extension imagesListVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCollectionCell", for: indexPath as IndexPath) as! imagesCollectionCell
        let model = items
        let innerArrayIndex = indexPath.row % model[indexPath.row].photos.count
        let photo = model[indexPath.row].photos[innerArrayIndex]
        cell.configure(with: cellViewModel(photoGrapherName: photo.photographer , imageURL: photo.src.tiny ))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 15) / 2)
        return CGSize(width: width, height: width + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == collectionView.numberOfItems(inSection: 0) - 1 {
            bottomLoader.isHidden = false
            bottomLoader.startAnimating()
            self.perform(#selector(getMoreImages), with: nil, afterDelay: 1.0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! imagesCollectionCell
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "cropImageVC") as? cropImageVC
        vc?.photoThumbnail = cell.imagesIcon.image
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

