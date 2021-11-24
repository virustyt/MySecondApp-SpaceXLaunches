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
        //setUp
        let containerView = transitionContext.containerView

        guard let detailsViewController = transitionContext.viewController(forKey: presenting ? .to : .from) as? RocketDetailViewController,
              let detailsView = detailsViewController.view,
              let allRocketsViewController = transitionContext.viewController(forKey: presenting ? .from : .to) as? RocketsViewController,
              let selectedCell = allRocketsViewController.selectedCell,
              let allRocketsView = transitionContext.view(forKey: presenting ? .from : .to)
        else { return }
        
        containerView.addSubview(presenting ? detailsView : allRocketsView)
        containerView.bringSubviewToFront(detailsView)
        containerView.layoutIfNeeded()

        guard let cellOriginFrame = originFrame 
        else { return }
        
        let heightToWidthCellRatio:CGFloat = selectedCell.frame.height / selectedCell.frame.width
        let viewLikeCellFinalFrame = CGRect(x: 0,
                                            y: 0,
                                            width: detailsView.frame.width,
                                            height: detailsView.frame.width * heightToWidthCellRatio)
        
        let (initialFrame, finalFrame) = presenting ? (cellOriginFrame, viewLikeCellFinalFrame) : (viewLikeCellFinalFrame, cellOriginFrame)

        let detailsViewScaleX: CGFloat =  presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let detailsViewScaleY: CGFloat = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        let detailsViewScaleTransform: CGAffineTransform = .init(scaleX: detailsViewScaleX,
                                                                 y: detailsViewScaleY)

        let detailsViewHeight = detailsView.frame.height
        let finalImageHeight = detailsViewController.rocketImageViewHeightConstraint.constant

        detailsView.frame.size = presenting ? finalFrame.size : initialFrame.size
        detailsView.clipsToBounds = true
        
        if presenting {
            detailsViewController.containerView.alpha = 0
            detailsViewController.rocketImageViewHeightConstraint.constant = selectedCell.rocketImageView.frame.height
            
            detailsView.transform  = detailsViewScaleTransform
            
            detailsView.center = CGPoint(x: initialFrame.midX,
                                         y: initialFrame.midY)
            detailsView.layer.cornerRadius = 20
            detailsView.clipsToBounds = true
            detailsView.layoutIfNeeded()
        }
        

        //Animate
        UIView.animate(withDuration: duration,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       animations: {
                        detailsView.transform = self.presenting ? .identity : detailsViewScaleTransform
                        detailsView.center = CGPoint(x: finalFrame.midX,
                                                         y: finalFrame.midY)
                        detailsViewController.rocketImageViewHeightConstraint.constant = self.presenting ? finalImageHeight : selectedCell.rocketImageView.frame.height
                        detailsView.layer.cornerRadius = self.presenting ? 0 : 20
                        detailsView.layoutIfNeeded()
                       },
                       completion: {_ in
                        UIView.animate(withDuration: 1, animations: {
                            if self.presenting {
                                detailsView.frame.size.height = detailsViewHeight
                                detailsView.layoutIfNeeded()
                                detailsViewController.containerView.alpha = 1
                            }
                        }, completion: {_ in
                            if !self.presenting {
                                (transitionContext.viewController(forKey: .to) as! RocketsViewController).selectedCell?.alpha = 1
                            }
                            transitionContext.completeTransition(true)})
                       })
    }
}

