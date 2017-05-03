//
//  ImagePresentedAnimator.swift
//  Kushiterest
//
//  Created by Kentaro on 2016/11/19.
//  Copyright © 2016年 Kentaro. All rights reserved.
//

import UIKit

final class ImagePresentedAnimator: NSObject {}

extension ImagePresentedAnimator: UIViewControllerAnimatedTransitioning {
    
    private static let presentedDuration = 0.3
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return ImagePresentedAnimator.presentedDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let sourceVC = transitionContext.viewController(forKey: .from) as? ImageSourceTransitionType,
            let distinationVC = transitionContext.viewController(forKey: .to) as? ImageDistinationTransitionType,
            let selectedIndexPath = sourceVC.collectionView.indexPathsForSelectedItems?.first,
            let selectedCell = sourceVC.collectionView.cellForItem(at: selectedIndexPath) as? ImageCollectionViewCellType else { return }
        
        let containerView = transitionContext.containerView
        let animationDuration = transitionDuration(using: transitionContext)
        let selectedImage = selectedCell.imageView.image
        let selectedCellsFrame = containerView.convert(selectedCell.imageView.frame, from: selectedCell.imageView.superview)
        
        let selectedImageWrapperView = UIView.init(frame: selectedCellsFrame)
        selectedImageWrapperView.backgroundColor = UIColor.clear
        selectedImageWrapperView.clipsToBounds = true
        
        let imageView = UIImageView.init(image: selectedImage)
        imageView.frame = CGRect(x: 0.0, y: 0.0, width: selectedCellsFrame.width, height: selectedCellsFrame.height)
        imageView.contentMode = distinationVC.imageView.contentMode
        imageView.autoresizingMask = [.flexibleHeight,.flexibleWidth,.flexibleTopMargin,.flexibleBottomMargin]
        selectedImageWrapperView.addSubview(imageView)
        
        containerView.addSubview(selectedImageWrapperView)
        
        let whiteBackgroundView = UIView.init(frame: sourceVC.baseView.frame)
        whiteBackgroundView.backgroundColor = UIColor.white
        containerView.insertSubview(whiteBackgroundView, belowSubview: selectedImageWrapperView)
        distinationVC.baseView.alpha = 0.0
        containerView.addSubview(distinationVC.baseView)
        
        let rect = CGRect(x: 0.0,
                          y: 0.0,
                          width: Double(distinationVC.baseView.frame.width),
                          height: Double(distinationVC.baseView.frame.height))
        let imageViewFinalFrame = containerView.convert(rect, from: distinationVC.baseView)
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
                        selectedImageWrapperView.frame = imageViewFinalFrame
        }) { (finished) in
            distinationVC.imageView.image = selectedImage
            distinationVC.baseView.alpha = 1.0
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
