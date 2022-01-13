//
//  LaunchAnimatorViewController.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 13.01.2022.
//

import UIKit

class LaunchAnimatorViewController: NSObject {
    var duration: TimeInterval = 2
    var originFrame: CGRect?
    var presenting: Bool = false
}

extension LaunchAnimatorViewController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //setUp
        let containerView = transitionContext.containerView

        guard let detailsViewController = transitionContext.viewController(forKey: presenting ? .to : .from) as? LaunchDetailsViewController,
              let detailsView = detailsViewController.view,
              let launchesViewController = transitionContext.viewController(forKey: presenting ? .from : .to) as? LaunchesViewController,
              let selectedCell = launchesViewController.selectedCell,
              let launchesView = transitionContext.view(forKey: presenting ? .from : .to)
        else { return }

        containerView.addSubview(presenting ? detailsView : launchesView)
        containerView.bringSubviewToFront(detailsView)

        guard let selectedCellOriginFrame = originFrame
        else { return }

        detailsView.layoutIfNeeded()
        let launchDetailsViewFinalFrame = detailsViewController.launchCellsFrame()

        let (initialFrame, finalFrame) = presenting ? (selectedCellOriginFrame, launchDetailsViewFinalFrame) : (launchDetailsViewFinalFrame, selectedCellOriginFrame)

        if presenting {
            detailsView.frame = initialFrame
            detailsViewController.setLaunchCellsViewTopInset(to: 0)
        }
        detailsView.layoutIfNeeded()




        //Animate
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            //animate detailsView frame

            detailsView.frame = finalFrame

            detailsViewController.setLaunchCellsViewTopInset(to: 10)

            detailsView.layoutIfNeeded()
        }, completion: { _ in
            if !self.presenting {
                (transitionContext.viewController(forKey: .to) as! LaunchesViewController).selectedCell?.alpha = 1
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
