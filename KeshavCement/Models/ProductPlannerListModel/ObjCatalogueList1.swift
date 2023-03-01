/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ObjCatalogueList1 : Codable {
	let catalogueId : Int?
	let catalogueName : Int?
	let productName : String?
	let productImage : String?
	let productImageServerPath : String?
	let productCode : String?
	let productDesc : String?
	let pointsRequired : Int?
	let hasPartialPayment : Bool?
	let partialPaymentCash : Int?
	let deliveryType : String?
	let noOfQuantity : Int?
	let noOfPointsDebit : Double?
	let noOfCartQuantity : Int?
	let totalCash : Int?
	let redemptionRefno : String?
	let redemptionId : Int?
	let loyaltyId : String?
	let redemptionDate : String?
	let jRedemptionDate : String?
	let vendorId : Int?
	let vendorName : String?
	let isPlanner : Bool?
	let redemptionPlannerId : Int?
	let pointBalance : Double?
	let averageEarning : String?
	let actualRedemptionDate : String?
	let pointReqToAcheiveProduct : Int?
	let min_points : String?
	let max_points : String?
	let barcode : String?
	let pointRedem : Int?
	let product_type : Int?
	let countryID : Int?
	let commandName : String?
	let activeStatus : Bool?
	let msqa : Int?
	let redeemablePointBalance : Double?
	let minimumStockQunty : Int?
	let redeemableEncashBalance : Int?
	let redeemableAverageEarning : String?
	let selectedStatus : Int?
	let isCash : Bool?
	let countryCurrencyCode : String?
	let pointsPerUnit : Int?
	let cashPerUnit : Int?
	let approverName : String?
	let expectedDelivery : String?
	let additionalRemarks : String?
	let isApproved : Bool?
	let isPopularCount : Int?
	let createdBy : String?
	let expiryDate : String?
	let expiryOn : Int?
	let categoryID : Int?
	let locationId : Int?
	let cashValue : Int?
	let redemptionStatus : String?
	let greaterAvgCash : String?
	let avgGreaterExpDate : String?
	let dailyAvgCash : String?
	let avgExpDate : String?
	let lesserAvgCash : String?
	let avgLesserExpDate : String?
	let segmentDetails : String?
	let dreamGiftId : Int?
	let redemptionTypeId : Int?
	let catalogueType : Int?
	let multipleRedIds : String?
	let memberName : String?
	let mobile : String?
	let createdDate : String?
	let plannerStatus : String?
	let total_Row : Int?
	let redeemableAverageEarning12 : Int?
	let redeemableAverageEarning6 : Int?
	let catalougeBrandName : String?
	let isAddPlanner : Bool?
	let comments : String?
	let customerCartId : Int?
	let catalogueIdExist : Int?
	let catalogueRedemptionIdExists : Int?
	let categoryName : String?
	let sumOfTotalPointsRequired : Double?
	let mrp : String?
	let schemeId : Int?
	let domainName : String?
	let tdsPercentage : Int?
	let proposedTDS : Double?
	let applicableTds : Double?
	let sumOfRedeemableWithTDS : Double?
	let is_Redeemable : Int?
	let is_CartRedeemable : Int?
	let result : Int?
	let averageEarningperDay : String?
	let daysRequiredToAchieveGoal : String?
	let averageEarningPerMonth : String?
	let monthsRequiredToAchieveGoal : String?
	let achievementDateMonthWize : String?
	let achievementDateDayWize : String?
	let redeemedCatalogueType : String?
	let catogoryId : Int?
	let catalogueBrandId : Int?
	let catalogueBrandName : String?
	let catalogueBrandCode : String?
	let catalogueBrandDesc : String?
	let brandTermsAndConditions : String?
	let catogoryName : String?
	let subCategoryID : Int?
	let subCategoryName : String?
	let categoryParentID : Int?
	let merchantId : Int?
	let merchantName : String?
	let status : Int?
	let fromDate : String?
	let toDate : String?
	let jFromDate : String?
	let jToDate : String?
	let color_Id : Int?
	let color_Name : String?
	let color_Code : String?
	let modelName : String?
	let modelId : Int?
	let userAccess : Int?
	let catogoryImage : String?
	let termsCondition : String?
	let token : String?
	let actorId : Int?
	let isActive : Bool?
	let actorRole : String?
	let actionType : Int?

	enum CodingKeys: String, CodingKey {

		case catalogueId = "catalogueId"
		case catalogueName = "catalogueName"
		case productName = "productName"
		case productImage = "productImage"
		case productImageServerPath = "productImageServerPath"
		case productCode = "productCode"
		case productDesc = "productDesc"
		case pointsRequired = "pointsRequired"
		case hasPartialPayment = "hasPartialPayment"
		case partialPaymentCash = "partialPaymentCash"
		case deliveryType = "deliveryType"
		case noOfQuantity = "noOfQuantity"
		case noOfPointsDebit = "noOfPointsDebit"
		case noOfCartQuantity = "noOfCartQuantity"
		case totalCash = "totalCash"
		case redemptionRefno = "redemptionRefno"
		case redemptionId = "redemptionId"
		case loyaltyId = "loyaltyId"
		case redemptionDate = "redemptionDate"
		case jRedemptionDate = "jRedemptionDate"
		case vendorId = "vendorId"
		case vendorName = "vendorName"
		case isPlanner = "isPlanner"
		case redemptionPlannerId = "redemptionPlannerId"
		case pointBalance = "pointBalance"
		case averageEarning = "averageEarning"
		case actualRedemptionDate = "actualRedemptionDate"
		case pointReqToAcheiveProduct = "pointReqToAcheiveProduct"
		case min_points = "min_points"
		case max_points = "max_points"
		case barcode = "barcode"
		case pointRedem = "pointRedem"
		case product_type = "product_type"
		case countryID = "countryID"
		case commandName = "commandName"
		case activeStatus = "activeStatus"
		case msqa = "msqa"
		case redeemablePointBalance = "redeemablePointBalance"
		case minimumStockQunty = "minimumStockQunty"
		case redeemableEncashBalance = "redeemableEncashBalance"
		case redeemableAverageEarning = "redeemableAverageEarning"
		case selectedStatus = "selectedStatus"
		case isCash = "isCash"
		case countryCurrencyCode = "countryCurrencyCode"
		case pointsPerUnit = "pointsPerUnit"
		case cashPerUnit = "cashPerUnit"
		case approverName = "approverName"
		case expectedDelivery = "expectedDelivery"
		case additionalRemarks = "additionalRemarks"
		case isApproved = "isApproved"
		case isPopularCount = "isPopularCount"
		case createdBy = "createdBy"
		case expiryDate = "expiryDate"
		case expiryOn = "expiryOn"
		case categoryID = "categoryID"
		case locationId = "locationId"
		case cashValue = "cashValue"
		case redemptionStatus = "redemptionStatus"
		case greaterAvgCash = "greaterAvgCash"
		case avgGreaterExpDate = "avgGreaterExpDate"
		case dailyAvgCash = "dailyAvgCash"
		case avgExpDate = "avgExpDate"
		case lesserAvgCash = "lesserAvgCash"
		case avgLesserExpDate = "avgLesserExpDate"
		case segmentDetails = "segmentDetails"
		case dreamGiftId = "dreamGiftId"
		case redemptionTypeId = "redemptionTypeId"
		case catalogueType = "catalogueType"
		case multipleRedIds = "multipleRedIds"
		case memberName = "memberName"
		case mobile = "mobile"
		case createdDate = "createdDate"
		case plannerStatus = "plannerStatus"
		case total_Row = "total_Row"
		case redeemableAverageEarning12 = "redeemableAverageEarning12"
		case redeemableAverageEarning6 = "redeemableAverageEarning6"
		case catalougeBrandName = "catalougeBrandName"
		case isAddPlanner = "isAddPlanner"
		case comments = "comments"
		case customerCartId = "customerCartId"
		case catalogueIdExist = "catalogueIdExist"
		case catalogueRedemptionIdExists = "catalogueRedemptionIdExists"
		case categoryName = "categoryName"
		case sumOfTotalPointsRequired = "sumOfTotalPointsRequired"
		case mrp = "mrp"
		case schemeId = "schemeId"
		case domainName = "domainName"
		case tdsPercentage = "tdsPercentage"
		case proposedTDS = "proposedTDS"
		case applicableTds = "applicableTds"
		case sumOfRedeemableWithTDS = "sumOfRedeemableWithTDS"
		case is_Redeemable = "is_Redeemable"
		case is_CartRedeemable = "is_CartRedeemable"
		case result = "result"
		case averageEarningperDay = "averageEarningperDay"
		case daysRequiredToAchieveGoal = "daysRequiredToAchieveGoal"
		case averageEarningPerMonth = "averageEarningPerMonth"
		case monthsRequiredToAchieveGoal = "monthsRequiredToAchieveGoal"
		case achievementDateMonthWize = "achievementDateMonthWize"
		case achievementDateDayWize = "achievementDateDayWize"
		case redeemedCatalogueType = "redeemedCatalogueType"
		case catogoryId = "catogoryId"
		case catalogueBrandId = "catalogueBrandId"
		case catalogueBrandName = "catalogueBrandName"
		case catalogueBrandCode = "catalogueBrandCode"
		case catalogueBrandDesc = "catalogueBrandDesc"
		case brandTermsAndConditions = "brandTermsAndConditions"
		case catogoryName = "catogoryName"
		case subCategoryID = "subCategoryID"
		case subCategoryName = "subCategoryName"
		case categoryParentID = "categoryParentID"
		case merchantId = "merchantId"
		case merchantName = "merchantName"
		case status = "status"
		case fromDate = "fromDate"
		case toDate = "toDate"
		case jFromDate = "jFromDate"
		case jToDate = "jToDate"
		case color_Id = "color_Id"
		case color_Name = "color_Name"
		case color_Code = "color_Code"
		case modelName = "modelName"
		case modelId = "modelId"
		case userAccess = "userAccess"
		case catogoryImage = "catogoryImage"
		case termsCondition = "termsCondition"
		case token = "token"
		case actorId = "actorId"
		case isActive = "isActive"
		case actorRole = "actorRole"
		case actionType = "actionType"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		catalogueId = try values.decodeIfPresent(Int.self, forKey: .catalogueId)
		catalogueName = try values.decodeIfPresent(Int.self, forKey: .catalogueName)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		productImage = try values.decodeIfPresent(String.self, forKey: .productImage)
		productImageServerPath = try values.decodeIfPresent(String.self, forKey: .productImageServerPath)
		productCode = try values.decodeIfPresent(String.self, forKey: .productCode)
		productDesc = try values.decodeIfPresent(String.self, forKey: .productDesc)
		pointsRequired = try values.decodeIfPresent(Int.self, forKey: .pointsRequired)
		hasPartialPayment = try values.decodeIfPresent(Bool.self, forKey: .hasPartialPayment)
		partialPaymentCash = try values.decodeIfPresent(Int.self, forKey: .partialPaymentCash)
		deliveryType = try values.decodeIfPresent(String.self, forKey: .deliveryType)
		noOfQuantity = try values.decodeIfPresent(Int.self, forKey: .noOfQuantity)
		noOfPointsDebit = try values.decodeIfPresent(Double.self, forKey: .noOfPointsDebit)
		noOfCartQuantity = try values.decodeIfPresent(Int.self, forKey: .noOfCartQuantity)
		totalCash = try values.decodeIfPresent(Int.self, forKey: .totalCash)
		redemptionRefno = try values.decodeIfPresent(String.self, forKey: .redemptionRefno)
		redemptionId = try values.decodeIfPresent(Int.self, forKey: .redemptionId)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		redemptionDate = try values.decodeIfPresent(String.self, forKey: .redemptionDate)
		jRedemptionDate = try values.decodeIfPresent(String.self, forKey: .jRedemptionDate)
		vendorId = try values.decodeIfPresent(Int.self, forKey: .vendorId)
		vendorName = try values.decodeIfPresent(String.self, forKey: .vendorName)
		isPlanner = try values.decodeIfPresent(Bool.self, forKey: .isPlanner)
		redemptionPlannerId = try values.decodeIfPresent(Int.self, forKey: .redemptionPlannerId)
		pointBalance = try values.decodeIfPresent(Double.self, forKey: .pointBalance)
		averageEarning = try values.decodeIfPresent(String.self, forKey: .averageEarning)
		actualRedemptionDate = try values.decodeIfPresent(String.self, forKey: .actualRedemptionDate)
		pointReqToAcheiveProduct = try values.decodeIfPresent(Int.self, forKey: .pointReqToAcheiveProduct)
		min_points = try values.decodeIfPresent(String.self, forKey: .min_points)
		max_points = try values.decodeIfPresent(String.self, forKey: .max_points)
		barcode = try values.decodeIfPresent(String.self, forKey: .barcode)
		pointRedem = try values.decodeIfPresent(Int.self, forKey: .pointRedem)
		product_type = try values.decodeIfPresent(Int.self, forKey: .product_type)
		countryID = try values.decodeIfPresent(Int.self, forKey: .countryID)
		commandName = try values.decodeIfPresent(String.self, forKey: .commandName)
		activeStatus = try values.decodeIfPresent(Bool.self, forKey: .activeStatus)
		msqa = try values.decodeIfPresent(Int.self, forKey: .msqa)
		redeemablePointBalance = try values.decodeIfPresent(Double.self, forKey: .redeemablePointBalance)
		minimumStockQunty = try values.decodeIfPresent(Int.self, forKey: .minimumStockQunty)
		redeemableEncashBalance = try values.decodeIfPresent(Int.self, forKey: .redeemableEncashBalance)
		redeemableAverageEarning = try values.decodeIfPresent(String.self, forKey: .redeemableAverageEarning)
		selectedStatus = try values.decodeIfPresent(Int.self, forKey: .selectedStatus)
		isCash = try values.decodeIfPresent(Bool.self, forKey: .isCash)
		countryCurrencyCode = try values.decodeIfPresent(String.self, forKey: .countryCurrencyCode)
		pointsPerUnit = try values.decodeIfPresent(Int.self, forKey: .pointsPerUnit)
		cashPerUnit = try values.decodeIfPresent(Int.self, forKey: .cashPerUnit)
		approverName = try values.decodeIfPresent(String.self, forKey: .approverName)
		expectedDelivery = try values.decodeIfPresent(String.self, forKey: .expectedDelivery)
		additionalRemarks = try values.decodeIfPresent(String.self, forKey: .additionalRemarks)
		isApproved = try values.decodeIfPresent(Bool.self, forKey: .isApproved)
		isPopularCount = try values.decodeIfPresent(Int.self, forKey: .isPopularCount)
		createdBy = try values.decodeIfPresent(String.self, forKey: .createdBy)
		expiryDate = try values.decodeIfPresent(String.self, forKey: .expiryDate)
		expiryOn = try values.decodeIfPresent(Int.self, forKey: .expiryOn)
		categoryID = try values.decodeIfPresent(Int.self, forKey: .categoryID)
		locationId = try values.decodeIfPresent(Int.self, forKey: .locationId)
		cashValue = try values.decodeIfPresent(Int.self, forKey: .cashValue)
		redemptionStatus = try values.decodeIfPresent(String.self, forKey: .redemptionStatus)
		greaterAvgCash = try values.decodeIfPresent(String.self, forKey: .greaterAvgCash)
		avgGreaterExpDate = try values.decodeIfPresent(String.self, forKey: .avgGreaterExpDate)
		dailyAvgCash = try values.decodeIfPresent(String.self, forKey: .dailyAvgCash)
		avgExpDate = try values.decodeIfPresent(String.self, forKey: .avgExpDate)
		lesserAvgCash = try values.decodeIfPresent(String.self, forKey: .lesserAvgCash)
		avgLesserExpDate = try values.decodeIfPresent(String.self, forKey: .avgLesserExpDate)
		segmentDetails = try values.decodeIfPresent(String.self, forKey: .segmentDetails)
		dreamGiftId = try values.decodeIfPresent(Int.self, forKey: .dreamGiftId)
		redemptionTypeId = try values.decodeIfPresent(Int.self, forKey: .redemptionTypeId)
		catalogueType = try values.decodeIfPresent(Int.self, forKey: .catalogueType)
		multipleRedIds = try values.decodeIfPresent(String.self, forKey: .multipleRedIds)
		memberName = try values.decodeIfPresent(String.self, forKey: .memberName)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
		plannerStatus = try values.decodeIfPresent(String.self, forKey: .plannerStatus)
		total_Row = try values.decodeIfPresent(Int.self, forKey: .total_Row)
		redeemableAverageEarning12 = try values.decodeIfPresent(Int.self, forKey: .redeemableAverageEarning12)
		redeemableAverageEarning6 = try values.decodeIfPresent(Int.self, forKey: .redeemableAverageEarning6)
		catalougeBrandName = try values.decodeIfPresent(String.self, forKey: .catalougeBrandName)
		isAddPlanner = try values.decodeIfPresent(Bool.self, forKey: .isAddPlanner)
		comments = try values.decodeIfPresent(String.self, forKey: .comments)
		customerCartId = try values.decodeIfPresent(Int.self, forKey: .customerCartId)
		catalogueIdExist = try values.decodeIfPresent(Int.self, forKey: .catalogueIdExist)
		catalogueRedemptionIdExists = try values.decodeIfPresent(Int.self, forKey: .catalogueRedemptionIdExists)
		categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
		sumOfTotalPointsRequired = try values.decodeIfPresent(Double.self, forKey: .sumOfTotalPointsRequired)
		mrp = try values.decodeIfPresent(String.self, forKey: .mrp)
		schemeId = try values.decodeIfPresent(Int.self, forKey: .schemeId)
		domainName = try values.decodeIfPresent(String.self, forKey: .domainName)
		tdsPercentage = try values.decodeIfPresent(Int.self, forKey: .tdsPercentage)
		proposedTDS = try values.decodeIfPresent(Double.self, forKey: .proposedTDS)
		applicableTds = try values.decodeIfPresent(Double.self, forKey: .applicableTds)
		sumOfRedeemableWithTDS = try values.decodeIfPresent(Double.self, forKey: .sumOfRedeemableWithTDS)
		is_Redeemable = try values.decodeIfPresent(Int.self, forKey: .is_Redeemable)
		is_CartRedeemable = try values.decodeIfPresent(Int.self, forKey: .is_CartRedeemable)
		result = try values.decodeIfPresent(Int.self, forKey: .result)
		averageEarningperDay = try values.decodeIfPresent(String.self, forKey: .averageEarningperDay)
		daysRequiredToAchieveGoal = try values.decodeIfPresent(String.self, forKey: .daysRequiredToAchieveGoal)
		averageEarningPerMonth = try values.decodeIfPresent(String.self, forKey: .averageEarningPerMonth)
		monthsRequiredToAchieveGoal = try values.decodeIfPresent(String.self, forKey: .monthsRequiredToAchieveGoal)
		achievementDateMonthWize = try values.decodeIfPresent(String.self, forKey: .achievementDateMonthWize)
		achievementDateDayWize = try values.decodeIfPresent(String.self, forKey: .achievementDateDayWize)
		redeemedCatalogueType = try values.decodeIfPresent(String.self, forKey: .redeemedCatalogueType)
		catogoryId = try values.decodeIfPresent(Int.self, forKey: .catogoryId)
		catalogueBrandId = try values.decodeIfPresent(Int.self, forKey: .catalogueBrandId)
		catalogueBrandName = try values.decodeIfPresent(String.self, forKey: .catalogueBrandName)
		catalogueBrandCode = try values.decodeIfPresent(String.self, forKey: .catalogueBrandCode)
		catalogueBrandDesc = try values.decodeIfPresent(String.self, forKey: .catalogueBrandDesc)
		brandTermsAndConditions = try values.decodeIfPresent(String.self, forKey: .brandTermsAndConditions)
		catogoryName = try values.decodeIfPresent(String.self, forKey: .catogoryName)
		subCategoryID = try values.decodeIfPresent(Int.self, forKey: .subCategoryID)
		subCategoryName = try values.decodeIfPresent(String.self, forKey: .subCategoryName)
		categoryParentID = try values.decodeIfPresent(Int.self, forKey: .categoryParentID)
		merchantId = try values.decodeIfPresent(Int.self, forKey: .merchantId)
		merchantName = try values.decodeIfPresent(String.self, forKey: .merchantName)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		fromDate = try values.decodeIfPresent(String.self, forKey: .fromDate)
		toDate = try values.decodeIfPresent(String.self, forKey: .toDate)
		jFromDate = try values.decodeIfPresent(String.self, forKey: .jFromDate)
		jToDate = try values.decodeIfPresent(String.self, forKey: .jToDate)
		color_Id = try values.decodeIfPresent(Int.self, forKey: .color_Id)
		color_Name = try values.decodeIfPresent(String.self, forKey: .color_Name)
		color_Code = try values.decodeIfPresent(String.self, forKey: .color_Code)
		modelName = try values.decodeIfPresent(String.self, forKey: .modelName)
		modelId = try values.decodeIfPresent(Int.self, forKey: .modelId)
		userAccess = try values.decodeIfPresent(Int.self, forKey: .userAccess)
		catogoryImage = try values.decodeIfPresent(String.self, forKey: .catogoryImage)
		termsCondition = try values.decodeIfPresent(String.self, forKey: .termsCondition)
		token = try values.decodeIfPresent(String.self, forKey: .token)
		actorId = try values.decodeIfPresent(Int.self, forKey: .actorId)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		actorRole = try values.decodeIfPresent(String.self, forKey: .actorRole)
		actionType = try values.decodeIfPresent(Int.self, forKey: .actionType)
	}

}
