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

        guard let detailsViewController = transitionContext.viewController(forKey: presenting ? .to : .from) as? RocketDetailsViewController,
              let detailsView = detailsViewController.view,
              let allRocketsViewController = transitionContext.viewController(forKey: presenting ? .from : .to) as? RocketsViewController,
              let selectedCell = allRocketsViewController.selectedCell,
              let allRocketsView = transitionContext.view(forKey: presenting ? .from : .to)
        else { return }
        
        containerView.addSubview(presenting ? detailsView : allRocketsView)
        containerView.bringSubviewToFront(detailsView)
        containerView.layoutIfNeeded()

        guard let selectedCellOriginFrame = originFrame
        else { return }
        
        let heightToWidthSelectedCellsRatio:CGFloat = selectedCell.frame.height / selectedCell.frame.width
        let rocketDetailsViewFinalFrame = CGRect(x: 0,
                                            y: 0,
                                            width: detailsView.frame.width,
                                            height: detailsView.frame.width * heightToWidthSelectedCellsRatio)
        
        let (initialFrame, finalFrame) = presenting ? (selectedCellOriginFrame, rocketDetailsViewFinalFrame) : (rocketDetailsViewFinalFrame, selectedCellOriginFrame)

        let detailsViewScaleX: CGFloat =  presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let detailsViewScaleY: CGFloat = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height

        let detailsViewScaleTransform: CGAffineTransform = .init(scaleX: detailsViewScaleX,
                                                                 y: detailsViewScaleY)

        let detailsViewEtierScreenHeight = detailsView.frame.height
        
        let initialImageHeight = presenting ? selectedCell.rocketImageView.frame.height : detailsViewController.rocketImageViewHeightConstraint.constant
        let finalImageHeight = presenting ? detailsViewController.rocketImageViewHeightConstraint.constant : selectedCell.rocketImageView.frame.height
        
        detailsViewController.rocketImageViewHeightConstraint.constant = initialImageHeight / detailsViewScaleY
        
        detailsView.frame.size = presenting ? finalFrame.size : detailsView.frame.size
        detailsView.clipsToBounds = true
        
        if presenting {
            detailsViewController.containerView.alpha = 0

            detailsView.transform  = detailsViewScaleTransform
            
            detailsView.center = CGPoint(x: initialFrame.midX,
                                         y: initialFrame.midY)
            detailsView.layer.cornerRadius = 20
            detailsView.clipsToBounds = true
        }
        
        //set rocketTitleLabel position
        let originBottomConstant = detailsViewController.rocketTitleBottomAnchorConstraint.constant
        let originLeadingConstant = detailsViewController.rocketTitleLeadingAnchorConstraint.constant
        
        let cellTitleTopConstant = selectedCell.rocketTitleLabelTopAnchorConstraint.constant
        let cellTitleLeadingConstant = selectedCell.rocketTitleLabelLeadingAnchorConstraint.constant

        let detailsTitleHeight = selectedCell.rocketTitleLabel.frame.height
        
        detailsViewController.rocketTitleBottomAnchorConstraint.constant = presenting ? (cellTitleTopConstant + detailsTitleHeight) / detailsViewScaleY : originBottomConstant / detailsViewScaleY
        detailsViewController.rocketTitleLeadingAnchorConstraint.constant = presenting ? cellTitleLeadingConstant / detailsViewScaleX : originLeadingConstant / detailsViewScaleY
        
        //show/hide first/second rocketTitle
        detailsViewController.secondRocketNameOnlyForAnimationLabel.alpha = presenting ? 1 : 0
        detailsViewController.rocketNameLabel.alpha = presenting ? 0 : 1
        
        //expanding second rocketTitle
        detailsViewController.secondRocketNameOnlyForAnimationLabel.transform = .init(scaleX: 1/detailsViewScaleX,
                                                                                      y: 1/detailsViewScaleY)
        detailsViewController.secondRocketNameOnlyForAnimationLabel.layer.anchorPoint = .init(x: 0.5 * detailsViewScaleX, y: 0.5 / detailsViewScaleY)
        
        detailsView.layoutIfNeeded()
        
        //Animate
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            //animate detailsView frame
            detailsView.transform = self.presenting ? .identity : detailsViewScaleTransform
            detailsView.frame.origin = finalFrame.origin
            detailsView.frame.size.height = self.presenting ? detailsViewEtierScreenHeight : finalFrame.height
            
            detailsView.layer.cornerRadius = self.presenting ? 0 : 20
            
            if !self.presenting{
                detailsViewController.scrollView.setContentOffset(CGPoint(x: 0, y: -detailsViewController.view.safeAreaInsets.top ), animated: false)
            }

            //animate rocketTitleLabel position
            detailsViewController.rocketTitleBottomAnchorConstraint.constant = self.presenting ? originBottomConstant / detailsViewScaleY : (cellTitleTopConstant + detailsTitleHeight) / detailsViewScaleY
            detailsViewController.rocketTitleLeadingAnchorConstraint.constant = self.presenting ? originLeadingConstant / detailsViewScaleX : cellTitleLeadingConstant / detailsViewScaleX
            
            //animate rocketImage height
            detailsViewController.rocketImageViewHeightConstraint.constant = finalImageHeight / detailsViewScaleY
            
            detailsViewController.containerView.alpha = self.presenting ? 1 : 0
            
            //animate rocketTitleLabel transition
            detailsViewController.secondRocketNameOnlyForAnimationLabel.alpha = self.presenting ? 0 : 1
            detailsViewController.rocketNameLabel.alpha = self.presenting ? 1 : 0
            
            detailsView.layoutIfNeeded()
        }, completion: { _ in
            if !self.presenting {
                (transitionContext.viewController(forKey: .to) as! RocketsViewController).selectedCell?.alpha = 1
            }
            UIView.animate(withDuration: 1, animations: {
                if !self.presenting {
                    detailsView.alpha = 0
                }
            }, completion: {_ in
                transitionContext.completeTransition(true)
            })
        })
    }
}


