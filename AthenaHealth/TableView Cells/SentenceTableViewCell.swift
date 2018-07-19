//
//  SentenceTableViewCell.swift
//  AthenaHealth
//
//  Created by Saurabh Gupta on 19/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class SentenceTableViewCell: UITableViewCell {

    @IBOutlet weak var findingButton: UIButton! {
        didSet {
            findingButton.layer.cornerRadius = 4
            findingButton.layer.borderWidth = 1.0
            findingButton.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBAction func findingButtonTapped(_ sender: Any) {
        findingButton.backgroundColor = UIColor(cgColor: findingButton.layer.borderColor ?? UIColor.green.cgColor)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        findingButton.setTitle("", for: .normal)
        findingButton.backgroundColor = .white
    }
}
