/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct DashBoardModel : Codable {
	let objCustomerDashboardMenuList : String?
	let objCustomerDashboardList : [ObjCustomerDashboardList]?
	let objActivityDetailsList : String?
	let objActivityDetailsJsonList : [ObjActivityDetailsJsonList]?
	let objGamificationTransaction : String?
	let lstUserDashboardDetails : String?
	let lstPromotionListJsonApi : [LstPromotionListJsonApi]?
	let lstCustomerFeedBackJsonApi : [LstCustomerFeedBackJsonApi]?
	let lstLoyaltyProgramReport : [LstLoyaltyProgramReport]?
	let objImageGalleryList : String?
	let objCatalogueDetailsForCustomer : [ObjCatalogueDetailsForCustomer]?
	let activeStatus : Bool?
	let objProductList : String?
	let sessionID : String?
	let deviceID : String?
	let loggedDeviceName : String?
	let returnValue : Int?
	let returnMessage : String?
	let totalRecords : Int?

	enum CodingKeys: String, CodingKey {

		case objCustomerDashboardMenuList = "objCustomerDashboardMenuList"
		case objCustomerDashboardList = "objCustomerDashboardList"
		case objActivityDetailsList = "objActivityDetailsList"
		case objActivityDetailsJsonList = "objActivityDetailsJsonList"
		case objGamificationTransaction = "objGamificationTransaction"
		case lstUserDashboardDetails = "lstUserDashboardDetails"
		case lstPromotionListJsonApi = "lstPromotionListJsonApi"
		case lstCustomerFeedBackJsonApi = "lstCustomerFeedBackJsonApi"
		case lstLoyaltyProgramReport = "lstLoyaltyProgramReport"
		case objImageGalleryList = "objImageGalleryList"
		case objCatalogueDetailsForCustomer = "objCatalogueDetailsForCustomer"
		case activeStatus = "activeStatus"
		case objProductList = "objProductList"
		case sessionID = "sessionID"
		case deviceID = "deviceID"
		case loggedDeviceName = "loggedDeviceName"
		case returnValue = "returnValue"
		case returnMessage = "returnMessage"
		case totalRecords = "totalRecords"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		objCustomerDashboardMenuList = try values.decodeIfPresent(String.self, forKey: .objCustomerDashboardMenuList)
		objCustomerDashboardList = try values.decodeIfPresent([ObjCustomerDashboardList].self, forKey: .objCustomerDashboardList)
		objActivityDetailsList = try values.decodeIfPresent(String.self, forKey: .objActivityDetailsList)
		objActivityDetailsJsonList = try values.decodeIfPresent([ObjActivityDetailsJsonList].self, forKey: .objActivityDetailsJsonList)
		objGamificationTransaction = try values.decodeIfPresent(String.self, forKey: .objGamificationTransaction)
		lstUserDashboardDetails = try values.decodeIfPresent(String.self, forKey: .lstUserDashboardDetails)
		lstPromotionListJsonApi = try values.decodeIfPresent([LstPromotionListJsonApi].self, forKey: .lstPromotionListJsonApi)
		lstCustomerFeedBackJsonApi = try values.decodeIfPresent([LstCustomerFeedBackJsonApi].self, forKey: .lstCustomerFeedBackJsonApi)
		lstLoyaltyProgramReport = try values.decodeIfPresent([LstLoyaltyProgramReport].self, forKey: .lstLoyaltyProgramReport)
		objImageGalleryList = try values.decodeIfPresent(String.self, forKey: .objImageGalleryList)
		objCatalogueDetailsForCustomer = try values.decodeIfPresent([ObjCatalogueDetailsForCustomer].self, forKey: .objCatalogueDetailsForCustomer)
		activeStatus = try values.decodeIfPresent(Bool.self, forKey: .activeStatus)
		objProductList = try values.decodeIfPresent(String.self, forKey: .objProductList)
		sessionID = try values.decodeIfPresent(String.self, forKey: .sessionID)
		deviceID = try values.decodeIfPresent(String.self, forKey: .deviceID)
		loggedDeviceName = try values.decodeIfPresent(String.self, forKey: .loggedDeviceName)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
	}

}
