/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstWorkSiteInfo : Codable {
    let customerID : Int?
    let siteName : String?
    let stateID : Int?
    let cityID : Int?
    let address : String?
    let pincode : String?
    let landMark : String?
    let siteImageURl : String?
    let contactNumber : String?
    let workSiteID : Int?
    let stateName : String?
    let cityName : String?
    let verificationStatus : String?
    let countryID : Int?
    let verification : Int?
    let siteLocationID : Int?
    let siteUserID : Int?
    let contactPersonName : String?
    let addressLongitude : String?
    let addressLatitude : String?
    let domain : String?
    let updatedAddress : String?
    let workSiteApproverName : String?
    let totalRows : Int?
    let createdDate : String?
    let loyaltyID : String?
    let contactNumber1 : String?
    let contactPersonName1 : String?
    let remarks : String?
    let worklevel : String?
    let tentativeDate : String?
    let locationName : String?
    let points : Int?
    let token : String?
    let actorId : Int?
    let isActive : Bool?
    let actorRole : String?
    let actionType : Int?

    enum CodingKeys: String, CodingKey {

        case customerID = "customerID"
        case siteName = "siteName"
        case stateID = "stateID"
        case cityID = "cityID"
        case address = "address"
        case pincode = "pincode"
        case landMark = "landMark"
        case siteImageURl = "siteImageURl"
        case contactNumber = "contactNumber"
        case workSiteID = "workSiteID"
        case stateName = "stateName"
        case cityName = "cityName"
        case verificationStatus = "verificationStatus"
        case countryID = "countryID"
        case verification = "verification"
        case siteLocationID = "siteLocationID"
        case siteUserID = "siteUserID"
        case contactPersonName = "contactPersonName"
        case addressLongitude = "addressLongitude"
        case addressLatitude = "addressLatitude"
        case domain = "domain"
        case updatedAddress = "updatedAddress"
        case workSiteApproverName = "workSiteApproverName"
        case totalRows = "totalRows"
        case createdDate = "createdDate"
        case loyaltyID = "loyaltyID"
        case contactNumber1 = "contactNumber1"
        case contactPersonName1 = "contactPersonName1"
        case remarks = "remarks"
        case worklevel = "worklevel"
        case tentativeDate = "tentativeDate"
        case locationName = "locationName"
        case points = "points"
        case token = "token"
        case actorId = "actorId"
        case isActive = "isActive"
        case actorRole = "actorRole"
        case actionType = "actionType"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        customerID = try values.decodeIfPresent(Int.self, forKey: .customerID)
        siteName = try values.decodeIfPresent(String.self, forKey: .siteName)
        stateID = try values.decodeIfPresent(Int.self, forKey: .stateID)
        cityID = try values.decodeIfPresent(Int.self, forKey: .cityID)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
        landMark = try values.decodeIfPresent(String.self, forKey: .landMark)
        siteImageURl = try values.decodeIfPresent(String.self, forKey: .siteImageURl)
        contactNumber = try values.decodeIfPresent(String.self, forKey: .contactNumber)
        workSiteID = try values.decodeIfPresent(Int.self, forKey: .workSiteID)
        stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
        cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
        verificationStatus = try values.decodeIfPresent(String.self, forKey: .verificationStatus)
        countryID = try values.decodeIfPresent(Int.self, forKey: .countryID)
        verification = try values.decodeIfPresent(Int.self, forKey: .verification)
        siteLocationID = try values.decodeIfPresent(Int.self, forKey: .siteLocationID)
        siteUserID = try values.decodeIfPresent(Int.self, forKey: .siteUserID)
        contactPersonName = try values.decodeIfPresent(String.self, forKey: .contactPersonName)
        addressLongitude = try values.decodeIfPresent(String.self, forKey: .addressLongitude)
        addressLatitude = try values.decodeIfPresent(String.self, forKey: .addressLatitude)
        domain = try values.decodeIfPresent(String.self, forKey: .domain)
        updatedAddress = try values.decodeIfPresent(String.self, forKey: .updatedAddress)
        workSiteApproverName = try values.decodeIfPresent(String.self, forKey: .workSiteApproverName)
        totalRows = try values.decodeIfPresent(Int.self, forKey: .totalRows)
        createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
        loyaltyID = try values.decodeIfPresent(String.self, forKey: .loyaltyID)
        contactNumber1 = try values.decodeIfPresent(String.self, forKey: .contactNumber1)
        contactPersonName1 = try values.decodeIfPresent(String.self, forKey: .contactPersonName1)
        remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
        worklevel = try values.decodeIfPresent(String.self, forKey: .worklevel)
        tentativeDate = try values.decodeIfPresent(String.self, forKey: .tentativeDate)
        locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
        points = try values.decodeIfPresent(Int.self, forKey: .points)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
        actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
    }

}
