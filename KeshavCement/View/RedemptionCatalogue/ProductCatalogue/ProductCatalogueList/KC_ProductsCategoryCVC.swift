//
//  KC_ProductsCategoryCVC.swift
//  KeshavCement
//
//  Created by ADMIN on 05/01/2023.
//

import UIKit

class KC_ProductsCategoryCVC: UICollectionViewCell {
    
    @IBOutlet weak var categoryLbl: UILabel!
    override var isSelected: Bool {
        didSet {
            categoryLbl.textColor = isSelected ? .black : .black
            categoryLbl.backgroundColor = isSelected ? #colorLiteral(red: 1, green: 0.9877298474, blue: 0.5554133654, alpha: 1) : #colorLiteral(red: 0.8784313725, green: 0.8901960784, blue: 0.8901960784, alpha: 1)

        }
    }
}
