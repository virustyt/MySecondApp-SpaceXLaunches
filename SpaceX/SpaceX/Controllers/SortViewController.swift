//
//  SortViewController.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 16.11.2021.
//

import UIKit

class SortViewController: UIViewController {
    
    //MARK: - buttons
    private lazy var titleButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        
        let titleAtributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "SFProDisplay-Regular", size: 13) ?? UIFont.systemFontSize,
                                                             .foregroundColor: UIColor.slateGray]
        let buttonTitle = NSAttributedString(string: titleForSortOption[0] ?? "", attributes: titleAtributes)
        button.setAttributedTitle(buttonTitle, for: .normal)

        return button
    }()
    
    private lazy var firstOptionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
        
        let titleAtributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "SFProDisplay-Regular", size: 17) ?? UIFont.systemFontSize,
                                                             .foregroundColor: UIColor.coral]
        let buttonTitle = NSAttributedString(string: titleForSortOption[1] ?? "", attributes: titleAtributes)
        button.setAttributedTitle(buttonTitle, for: .normal)
        
        return button
    }()
    
    private lazy var secondOptionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        button.setTitleColor(UIColor.yellow, for: .normal)
        
        let titleAtributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "SFProDisplay-Regular", size: 17) ?? UIFont.systemFontSize,
                                                             .foregroundColor: UIColor.coral]
        let buttonTitle = NSAttributedString(string: titleForSortOption[2] ?? "", attributes: titleAtributes)
        button.setAttributedTitle(buttonTitle, for: .normal)

        return button
    }()
    
    private lazy var thirdOptionButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(thirdButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        
        let titleAtributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "SFProDisplay-Regular", size: 17) ?? UIFont.systemFontSize,
                                                             .foregroundColor: UIColor.coral]
        let buttonTitle = NSAttributedString(string: titleForSortOption[3] ?? "", attributes: titleAtributes)
        button.setAttributedTitle(buttonTitle, for: .normal)

        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(cancelSortViewTapped), for: .touchUpInside)
        
        let titleAtributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "SFProDisplay-Bold", size: 17) ?? UIFont.systemFontSize,
                                                             .foregroundColor: UIColor.red]
        let buttonTitle = NSAttributedString(string: titleForSortOption[4] ?? "", attributes: titleAtributes)
        button.setAttributedTitle(buttonTitle, for: .normal)

        return button
    }()
    
    private lazy var containerView = UIView()
    private lazy var cancelButtonBottomAnchor = cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 336)
    
    enum kindOfViewModel{
        case rockets(controller: RocketsViewController)
        case launches(controller: LaunchesViewController)
        case launchpads(controller: LaunchpadsViewController)
    }
    
    var currentKindOfViewModelOnScreen: kindOfViewModel
    
    lazy var titleForSortOption: [Int : String] = {
        switch currentKindOfViewModelOnScreen {
        case .rockets:
            return [0: "Choose your option",
                    1: "First launch",
                    2: "Launch cost",
                    3: "Success rate",
                    4: "Chancel"]
        case .launches:
            return [0: "Choose your option",
                    1: "Launch date",
                    2: "Title",
                    3: "Date",
                    4: "Chancel"]
        case .launchpads:
            return [0: "Choose your option",
                    1: "Launch date",
                    2: "Title",
                    3: "Date",
                    4: "Chancel"]
        }
    }()
    
    //MARK: - inits
    init(forViewModelKind kind: kindOfViewModel) {
        self.currentKindOfViewModelOnScreen = kind
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
            self.cancelButtonBottomAnchor.constant = -60
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    //MARK: - private functions
    private func setUpConstraints(){
        view.addSubview(titleButton)
        view.addSubview(firstOptionButton)
        view.addSubview(secondOptionButton)
        view.addSubview(thirdOptionButton)
        view.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            titleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleButton.bottomAnchor.constraint(equalTo: firstOptionButton.topAnchor,constant: -1),
            titleButton.widthAnchor.constraint(equalToConstant: 359),
            titleButton.heightAnchor.constraint(equalToConstant: 45),

            firstOptionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstOptionButton.bottomAnchor.constraint(equalTo: secondOptionButton.topAnchor,constant: -1),
            firstOptionButton.widthAnchor.constraint(equalToConstant: 359),
            firstOptionButton.heightAnchor.constraint(equalToConstant: 59),

            secondOptionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondOptionButton.bottomAnchor.constraint(equalTo: thirdOptionButton.topAnchor,constant: -1),
            secondOptionButton.widthAnchor.constraint(equalToConstant: 359),
            secondOptionButton.heightAnchor.constraint(equalToConstant: 59),

            thirdOptionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdOptionButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor,constant: -8),
            thirdOptionButton.widthAnchor.constraint(equalToConstant: 359),
            thirdOptionButton.heightAnchor.constraint(equalToConstant: 59),
            
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 359),
            cancelButtonBottomAnchor,
            cancelButton.heightAnchor.constraint(equalToConstant: 59),
        ])

    }
    
    @objc private func firstButtonTapped(){
        switch currentKindOfViewModelOnScreen {
        case .rockets(controller: let rocketsVC):
            sortRocketsByLaunchDate(containedIn: rocketsVC)
        case .launches(controller: let launchesVC):
            sortLaunchesByLaunchDate(containedIn: launchesVC)
        case .launchpads(controller: let launchpadsVC):
            sortLaunchpadsByLaunchDate(containedIn: launchpadsVC)
        }
    }
    
    @objc private func secondButtonTapped(){
        switch currentKindOfViewModelOnScreen {
        case .rockets(controller: let rocketsVC):
            sortRocketsByLaunchCost(containedIn: rocketsVC)
        case .launches(controller: let launchesVC):
            sortLaunchesByTitle(containedIn: launchesVC)
        case .launchpads(controller: let launchpadsVC):
            sortLaunchpadsByTitle(containedIn: launchpadsVC)
        }
    }
    
    @objc private func thirdButtonTapped(){
        switch currentKindOfViewModelOnScreen {
        case .rockets(controller: let rocketsVC):
            sortRocketsBySuccessRate(containedIn: rocketsVC)
        case .launches(controller: let launchesVC):
            sortLaunchesByDate(containedIn: launchesVC)
        case .launchpads(controller: let launchpadsVC):
            sortLaunchpadsByDate(containedIn: launchpadsVC)
        }
    }
    
    @objc private func cancelSortViewTapped(){
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.backgroundColor = UIColor.darkGray.withAlphaComponent(0)
            self.cancelButtonBottomAnchor.constant = 336
            self.view.layoutIfNeeded()
        }, completion: { _ in self.dismiss(animated: false, completion: nil) })
        
    }
    
    //MARK: - sort rockets
    @objc private func sortRocketsByLaunchDate(containedIn rocketsVC: RocketsViewController){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd, yyyy")
        
        RocketViewModel.shared.sort(by: {
            guard let firstDate = dateFormatter.date(from: $0.firstFlight) else { return false }
            guard let secondDate = dateFormatter.date(from: $1.firstFlight) else { return true }
            return firstDate >= secondDate
        })
        
        let indexSet = IndexSet(integersIn: 0...0)
        rocketsVC.rocketsCollectionView?.reloadSections(indexSet)
    }
    @objc private func sortRocketsByLaunchCost(containedIn rocketsVC: RocketsViewController){
        RocketViewModel.shared.sort(by: {$0.rocket.costPerLaunch ?? 0 > $1.rocket.costPerLaunch ?? 0})
        let indexSet = IndexSet(integersIn: 0...0)
        rocketsVC.rocketsCollectionView?.reloadSections(indexSet)
    }
    @objc private func sortRocketsBySuccessRate(containedIn rocketsVC: RocketsViewController){
        RocketViewModel.shared.sort(by: {$0.rocket.successRatePct ?? 0 > $1.rocket.successRatePct ?? 0})
        let indexSet = IndexSet(integersIn: 0...0)
        rocketsVC.rocketsCollectionView?.reloadSections(indexSet)
    }
    
    //MARK: - sort launches
    @objc private func sortLaunchesByLaunchDate(containedIn launchesVC: LaunchesViewController){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd, yyyy")
        
        LaunchViewModel.shared.sort(by: {
            guard let firstDate = dateFormatter.date(from: $0.dateUTC) else { return false }
            guard let secondDate = dateFormatter.date(from: $1.dateUTC) else { return true }
            return firstDate >= secondDate
        })
        
        let indexSet = IndexSet(integersIn: 0...0)
        launchesVC.launchesCollectionView.reloadSections(indexSet)
    }
    @objc private func sortLaunchesByTitle(containedIn launchesVC: LaunchesViewController){
        LaunchViewModel.shared.sort(by: {
            $0.name <= $1.name
        })
        
        let indexSet = IndexSet(integersIn: 0...0)
        launchesVC.launchesCollectionView.reloadSections(indexSet)
    }
    @objc private func sortLaunchesByDate(containedIn launchesVC: LaunchesViewController){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd, yyyy")
        
        LaunchViewModel.shared.sort(by: {
            guard let firstDate = dateFormatter.date(from: $0.staticFireDateUTC) else { return false }
            guard let secondDate = dateFormatter.date(from: $1.staticFireDateUTC) else { return true }
            return firstDate >= secondDate
        })
        
        let indexSet = IndexSet(integersIn: 0...0)
        launchesVC.launchesCollectionView.reloadSections(indexSet)
    }
    
    //MARK: - sort launchpads
    // this is a diffrent story))
//    @objc private func sortLaunchpadsByLaunchDate(containedIn launchpads: LaunchpadsViewController){
//
//    }
//    @objc private func sortLaunchpadsByTitle(containedIn launchpads: LaunchpadsViewController){
//
//    }
//    @objc private func sortLaunchpadsByDate(containedIn launchpads: LaunchpadsViewController){
//
//    }
}


