//
//  AnimatorViewController.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 18.11.2021.
//

import UIKit

class AnimatorViewController: NSObject {

    var duration: TimeInterval = 2
    var originFrame: CGRect?
    var presenting: Bool = false
}

extension AnimatorViewController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //set up start state
        guard let detailImageViewController = transitionContext.viewController(forKey: presenting ? .to : .from) as? RocketDetailViewController
        else { return }
        
        print(1)
        
        let detailImageView = detailImageViewController.rocketImage // <- RocketImageView
        print(2)
        guard let mainImageViewOriginFrame = originFrame // <- place of cell with the same image in all rockets collectionView
        else { return }
        
//        let (initialFrame, finalFrame) = presenting ? (mainImageViewOriginFrame, detailImageView.frame) : (detailImageView.frame, mainImageViewOriginFrame)
        let detailImageFrame = CGRect(x: 0,
                                      y: 0,
                                      width: UIScreen.main.bounds.width,
                                      height: UIScreen.main.bounds.width * 0.8)
        let (initialFrame, finalFrame) = presenting ? (mainImageViewOriginFrame, detailImageFrame) : (detailImageFrame, mainImageViewOriginFrame)
        
//        let detailsImageScale = CGFloat( 0.5 ) //presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        
        let detailsImageScaleX = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let detailsImageScaleY = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        let detailsViewScaleTransform: CGAffineTransform = .init(scaleX: detailsImageScaleX,
                                                                 y: detailsImageScaleY)
        
        if presenting {
            detailImageView.transform  = detailsViewScaleTransform
//            detailImageView.frame.origin = initialFrame.origin
            detailImageView.center = CGPoint(x: initialFrame.midX,
                                             y: initialFrame.midY)
        }
        
        let containerView = transitionContext.containerView
        
        if let toView = transitionContext.view(forKey: .to) {
            containerView.addSubview(toView)
        }
        containerView.bringSubviewToFront(detailImageView)
        
        //Animate
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       animations: {
                        detailImageView.transform = self.presenting ? .identity : detailsViewScaleTransform
//                        detailImageView.frame.origin = finalFrame.origin
                        detailImageView.center = CGPoint(x: finalFrame.midX,
                                                         y: finalFrame.midY)
                        print("---Animation animate clouser. Frame: \(detailImageView.frame)")
                       },
                       completion: {_ in
                        if !self.presenting {
                            (transitionContext.viewController(forKey: .to) as! RocketsViewController).selectedCell?.alpha = 1
                        }
                        transitionContext.completeTransition(true)
                        print("---Animation complition clouser. Frame: \(detailImageView.frame)")
                       })
    }
}
