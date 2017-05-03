//
//  ImageDismissedAnimator.swift
//  Kushiterest
//
//  Created by Kentaro on 2016/11/19.
//  Copyright © 2016年 Kentaro. All rights reserved.
//

import UIKit

final class ImageDismissedAnimator: NSObject {}

extension ImageDismissedAnimator: UIViewControllerAnimatedTransitioning {
    
    private static let dismissedDuration = 0.3
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return ImageDismissedAnimator.dismissedDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let sourceVC = transitionContext.viewController(forKey: .from) as? ImageDistinationTransitionType,
            let distinationVC = transitionContext.viewController(forKey: .to) as? ImageSourceTransitionType,
            let selectedIndexPath = distinationVC.collectionView.indexPathsForSelectedItems?.first,
            let selectedCell = distinationVC.collectionView.cellForItem(at: selectedIndexPath) as? ImageCollectionViewCellType else { return }
        
        let containerView = transitionContext.containerView
        let animationDuration = transitionDuration(using: transitionContext)
        
        let snapshot = sourceVC.imageView.snapshotView(afterScreenUpdates: false)
        snapshot?.frame = containerView.convert(sourceVC.imageView.frame,
                                                to: sourceVC.imageView.superview)
        snapshot?.autoresizingMask = [.flexibleHeight,.flexibleWidth,.flexibleTopMargin,.flexibleBottomMargin]
        
        sourceVC.imageView.alpha = 0.0
        selectedCell.imageView.alpha = 0.0
        selectedCell.imageView.transform =  CGAffineTransform(scaleX: 1.1, y: 1.1)
        distinationVC.baseView.frame = transitionContext.finalFrame(for: distinationVC as! UIViewController)
        containerView.insertSubview(distinationVC.baseView, belowSubview: sourceVC.baseView)
        
        let imageWrapperView = UIView.init(frame: containerView.convert(sourceVC.imageView.frame,
                                                                        to: sourceVC.imageView.superview))
        imageWrapperView.clipsToBounds = true
        imageWrapperView.addSubview(snapshot!)
        containerView.addSubview(imageWrapperView)
        
        let whiteBackgroundView = UIView.init(frame: sourceVC.baseView.frame)
        whiteBackgroundView.backgroundColor = UIColor.white
        containerView.insertSubview(whiteBackgroundView, belowSubview: imageWrapperView)
        
        UIView.animateKeyframes(withDuration: animationDuration,
                                delay: 0.0,
                                options: UIViewKeyframeAnimationOptions.calculationModeLinear,
                                animations: {
                                    
                                    UIView .addKeyframe(withRelativeStartTime: 0.0,
                                                        relativeDuration: 1.0,
                                                        animations: {
                                                            sourceVC.baseView.alpha = 0.0
                                                            imageWrapperView.frame = containerView.convert(selectedCell.imageView.frame,
                                                                                                           from: selectedCell.imageView.superview)
                                                            whiteBackgroundView.alpha = 0.0
                                                            selectedCell.imageView.alpha = 1.0
                                    })
                                    UIView .addKeyframe(withRelativeStartTime: 0.95,
                                                        relativeDuration: 0.05,
                                                        animations: {
                                                            selectedCell.imageView.transform = .identity
                                                            snapshot?.alpha = 0.0
                                    })
        }) { (finished) in
            whiteBackgroundView.removeFromSuperview()
            snapshot?.removeFromSuperview()
            imageWrapperView.removeFromSuperview()
            sourceVC.imageView.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
