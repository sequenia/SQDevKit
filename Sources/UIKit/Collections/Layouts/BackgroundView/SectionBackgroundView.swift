//
//  SectionBackgroundView.swift
//  SQUIKit
//
//  Created by Nikolay Komissarov on 22.08.2022.
//

import UIKit
import SQExtensions
import SnapKit
import SQUIKit

// MARK: - SectionBackgroundView
class SectionBackgroundView: UICollectionReusableView {

// MARK: - Properties
    private var insetView = UIView()
    
    private var settings: UISettings = .default

// MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configure()
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.configure()
        self.setupLayout()
    }
    
// MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.insetView.sq.roundCorners(
            topLeft: self.settings.cornersRadiuses.topLeft,
            topRight: self.settings.cornersRadiuses.topRight,
            bottomLeft: self.settings.cornersRadiuses.bottomLeft,
            bottomRight: self.settings.cornersRadiuses.bottomRight
        )
    }

// MARK: - Life cycle
    override func apply(_ attributes: UICollectionViewLayoutAttributes) {
        super.apply(attributes)

        guard let customizableAttributes = attributes as? CustomizableLayoutAttributes else { return }

        self.settings = customizableAttributes.settings ?? .default

        self.insetView.backgroundColor = self.settings.backgroundColor
    }
}

// MARK: - SQConfigurableView
extension SectionBackgroundView: SQConfigurableView {

    func configure() {
        self.backgroundColor = .clear
        self.clipsToBounds = true
    }

    func setupLayout() {
        self.addSubview(self.insetView)

        self.insetView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Constants
public extension String {

    static let backgroundElementKind = "background"
}
