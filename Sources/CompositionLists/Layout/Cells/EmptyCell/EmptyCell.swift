//
//  SpacerCell.swift
//  WetNose
//
//  Created by Nikolay on 27/05/2022.
//  Copyright 2022 Sequenia. All rights reserved.
//

import UIKit
import SnapKit

public class EmptyCell: UICollectionViewCell {

// MARK: - Model
    private var model: EmptyModel?
    
// MARK: - UIViews
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

// MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Bind
    @discardableResult
    public func bind(model: EmptyModel) -> Self {
        self.model = model

        self.emptyView.snp.updateConstraints {
            $0.height.equalTo(model.height ?? .zero)
        }
        
        self.backgroundColor = model.backgroundColor
        self.contentView.backgroundColor = model.backgroundColor
        
        return self
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.emptyView)
        
        self.emptyView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().priority(.medium)
            $0.height.equalTo(CGFloat.zero)
        }
    }
}
