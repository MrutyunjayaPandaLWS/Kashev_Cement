//
//  SideMenuModel.swift
//  KeshavCement
//
//  Created by ADMIN on 18/02/2023.
//

import Foundation

struct SideMenuModel {
    var parentName : String?
    var parentList : [SecondMenuList]?
    var parentID : Int?
    var parentExpand : Bool?
    var parentImage : String?
    var parentDropDownImage: String?
}

struct SecondMenuList {
    var sideMenuItem : String?
    var sideMenuID : Int?
    var sidemenuImage : String?
}

