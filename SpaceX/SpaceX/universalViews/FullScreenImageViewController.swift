//
//  FullScreenImageViewController.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 13.01.2022.
//

import UIKit

class FullScreenImageViewController: UIViewController {

    private(set) var fullScreenImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    init() {
        super.init(nibName: nil, bundle: nil)

        view.addSubview(fullScreenImageView)
        fullScreenImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: fullScreenImageView.topAnchor),
            view.bottomAnchor.constraint(equalTo: fullScreenImageView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: fullScreenImageView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: fullScreenImageView.trailingAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
