//
//  ListViewController.swift
//  Kushiterest
//
//  Created by Kentaro on 2016/11/19.
//  Copyright © 2016年 Kentaro. All rights reserved.
//

import AVFoundation
import UIKit

final class ListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var baseView: UIView!
    
    let photos = PhotosPlistManager.load()
    var imageTransitioningDelegate: ImageTransitionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        if let layout = collectionView.collectionViewLayout as? KushiterestLayout {
            layout.delegate = self
        }
    }
}

//MARK:- UICollectionViewDataSource
extension ListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KushiterestCell.identifier,
                                                            for: indexPath) as? KushiterestCell else { fatalError() }
        cell.photo = photos[indexPath.item]
        
        return cell
    }
}

//MARK:- UICollectionViewDelegate
extension ListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if imageTransitioningDelegate == nil {
            imageTransitioningDelegate = ImageTransitionDelegate()
        }
        
        guard let vc = UIStoryboard(name: "DetailViewController",bundle: nil)
            .instantiateInitialViewController() as? DetailViewController else { return }
        vc.transitioningDelegate = imageTransitioningDelegate
        vc.imageToPresent = UIImage(named: photos[indexPath.item].image)
        
        present(vc, animated: true, completion: nil)
    }
}

//MARK:- PinterestLayoutDelegate
extension ListViewController: KushiterestLayoutDelegate {
    
    // 写真の高さを返す
    func collectionView(_ collectionView:UICollectionView,
                        heightForPhotoAtIndexPath indexPath:IndexPath ,
                        withWidth width:CGFloat) -> CGFloat {
        
        let photo = photos[indexPath.item]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        guard let image = UIImage(named: photo.image) else { fatalError() }
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
        
        return rect.size.height
    }
    
    // キャプションとコメントの高さを返す
    func collectionView(_ collectionView: UICollectionView,
                        heightForCaptionAndCommentAtIndexPath indexPath: IndexPath,
                        withWidth width: CGFloat) -> CGFloat {
        
        let photo = photos[indexPath.item]
        let captionrHeight = photo.heightForCaption(font: UIFont.systemFont(ofSize: Photo.captionFontSize),
                                                    width: width)
        let commentHeight = photo.heightForComment(font: UIFont.systemFont(ofSize: Photo.commentFontSize),
                                                   width: width)
        let height = Photo.padding + captionrHeight + commentHeight + Photo.padding
        
        return height
    }
}

extension ListViewController: ImageSourceTransitionType {}
