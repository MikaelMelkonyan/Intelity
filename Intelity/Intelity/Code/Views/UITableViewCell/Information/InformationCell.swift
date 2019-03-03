//
//  InformationCell.swift
//  Intelity
//
//  Created by Mikael on 3/2/19.
//  Copyright © 2019 Mikael-Melkonyan. All rights reserved.
//

import UIKit

final class InformationCell: SimpleCell {
    
    @IBOutlet weak private var descriptionText: UILabel!
    @IBOutlet weak private var tryAgainButton: UIButton!
    
    private var tryAgainAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tryAgainButton.setTitle("Try again", for: .normal)
        tryAgainButton.addTarget(self, action: #selector(tryAgain), for: .touchUpInside)
    }
    
    func fill(text: String, tryAgaing: @escaping (() -> ())) {
        descriptionText.text = text
        tryAgainAction = tryAgaing
    }
    
    @objc private func tryAgain() {
        tryAgainAction?()
    }
}
