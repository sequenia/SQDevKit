//
//  File.swift
//  
//
//  Created by Aleksandr Rudikov on 12.10.2023.
//

import UIKit

public class SQDisplayLink {
    
    private var completion: (() -> Void)?
    private var displayLink: CADisplayLink?
    
    @discardableResult
    public required init(completion: @escaping () -> Void) {
        self.completion = completion
        
        self.displayLink = CADisplayLink(target: self, selector: #selector(self.completionSelector))
        self.displayLink?.add(to: .main, forMode: .common)
    }
    
    @objc
    private func completionSelector() {
        self.completion?()
        self.displayLink?.invalidate()
    }
}
