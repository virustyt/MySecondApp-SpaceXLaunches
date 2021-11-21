//
//  DetailsView.swift
//  SpaceX
//
//  Created by Vladimir Oleinikov on 18.11.2021.
//

import UIKit

class DetailsView: UIView {
    
    var lengthOfTitleLabels: CGFloat = 125

    var mainTitle: String? {
        didSet{ overviewTitleLabel.text = mainTitle }
    }
    
    var firstLineTitle: String? {
        didSet{
            firstLineTitleLabel.text = firstLineTitle
        }
    }
    
    var firstLineVslue: String? {
        didSet{
            firstLineBodyLabel.text = firstLineVslue
            titlesStack.addArrangedSubview(firstLineTitleLabel)
            valuesStack.addArrangedSubview(firstLineBodyLabel)
        }
    }
    
    var secondLineTitle: String? {
        didSet{
            secondLineTitleLabel.text = secondLineTitle
        }
    }
    var secondLineValue: String? {
        didSet{
            secondLineBodyLabel.text = secondLineValue
            titlesStack.addArrangedSubview(secondLineTitleLabel)
            valuesStack.addArrangedSubview(secondLineBodyLabel)
        }
    }
    
    var thirdLineTitle: String? {
        didSet{
            thirdLineTitleLabel.text = thirdLineTitle
        }
    }
    
    var thirdLineValue: String? {
        didSet{
            thirdLineBodyLabel.text = thirdLineValue
            titlesStack.addArrangedSubview(thirdLineTitleLabel)
            valuesStack.addArrangedSubview(thirdLineBodyLabel)
        }
    }
    
    var thourthLineTitle: String?{
        didSet{
            thourthLineTitleLabel.text = thourthLineTitle
        }
    }
    
    var thourthLineValue: String?{
        didSet{
            thourthLineBodyLabel.text = thourthLineValue
            titlesStack.addArrangedSubview(thourthLineTitleLabel)
            valuesStack.addArrangedSubview(thourthLineBodyLabel)
        }
    }
    
    var fifthLineTitle: String?{
        didSet{
            fifthLineTitleLabel.text = fifthLineTitle
        }
    }
    
    var fifthLineValue: String?{
        didSet{
            fifthLineBodyLabel.text = fifthLineValue
            titlesStack.addArrangedSubview(fifthLineTitleLabel)
            valuesStack.addArrangedSubview(fifthLineBodyLabel)
        }
    }
    
    var sixthLineTitletitle: String?{
        didSet{
            sixthLineTitleLabel.text = sixthLineTitletitle
        }
    }
    
    var sixthLineValue: String?{
        didSet{
            sixthLineBodyLabel.text = sixthLineValue
            titlesStack.addArrangedSubview(sixthLineTitleLabel)
            valuesStack.addArrangedSubview(sixthLineBodyLabel)
        }
    }
    
    private let overviewTitleLabel = UILabel.descriptionTitleLabel
    
    private let firstLineTitleLabel = UILabel.titleLabelTwo
    private let firstLineBodyLabel = UILabel.bodyLabel
    
    private let secondLineTitleLabel = UILabel.titleLabelTwo
    private let secondLineBodyLabel = UILabel.bodyLabel
    
    private let thirdLineTitleLabel = UILabel.titleLabelTwo
    private let thirdLineBodyLabel = UILabel.bodyLabel
    
    private let thourthLineTitleLabel = UILabel.titleLabelTwo
    private let thourthLineBodyLabel = UILabel.bodyLabel
    
    private let fifthLineTitleLabel = UILabel.titleLabelTwo
    private let fifthLineBodyLabel = UILabel.bodyLabel
    
    private let sixthLineTitleLabel = UILabel.titleLabelTwo
    private let sixthLineBodyLabel = UILabel.bodyLabel
    
    let titlesStack = UIStackView()
    let valuesStack = UIStackView()
    
    private lazy var overviewStack: UIStackView = {

        titlesStack.axis = .vertical
        titlesStack.distribution = .equalSpacing
        titlesStack.spacing = 15
        titlesStack.alignment = .leading
        
        valuesStack.axis = .vertical
        valuesStack.distribution = .equalSpacing
        valuesStack.spacing = 15
        valuesStack.alignment = .leading
        
        let allDetailsStack = UIStackView(arrangedSubviews: [titlesStack, valuesStack])
        allDetailsStack.axis = .horizontal
        allDetailsStack.distribution = .equalSpacing
        allDetailsStack.spacing = 0
        
        let summaryStack = UIStackView(arrangedSubviews: [overviewTitleLabel, allDetailsStack])
        summaryStack.axis = .vertical
        summaryStack.distribution = .equalSpacing
        summaryStack.spacing = 20
        summaryStack.alignment = .leading
        
        summaryStack.translatesAutoresizingMaskIntoConstraints = false

        return summaryStack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(overviewStack)
        NSLayoutConstraint.activate([
            overviewStack.topAnchor.constraint(equalTo: topAnchor),
            overviewStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            overviewStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            overviewStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            firstLineTitleLabel.widthAnchor.constraint(equalToConstant: lengthOfTitleLabels),
            secondLineTitleLabel.widthAnchor.constraint(equalToConstant: lengthOfTitleLabels),
            thirdLineTitleLabel.widthAnchor.constraint(equalToConstant: lengthOfTitleLabels),
            thourthLineTitleLabel.widthAnchor.constraint(equalToConstant: lengthOfTitleLabels),
            fifthLineTitleLabel.widthAnchor.constraint(equalToConstant: lengthOfTitleLabels),
            sixthLineTitleLabel.widthAnchor.constraint(equalToConstant: lengthOfTitleLabels)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
