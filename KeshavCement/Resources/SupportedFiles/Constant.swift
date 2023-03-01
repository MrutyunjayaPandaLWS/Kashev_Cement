//
//  Constant.swift
//  CenturyPly_JSON
//
//  Created by ADMIN on 02/05/2022.
//

import UIKit


extension String{
    func localizableString(loc: String) -> String{
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

