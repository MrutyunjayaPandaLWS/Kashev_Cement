/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstCustParentChildMapping1 : Codable {
	let loyaltyID : String?
	let userID : Int?
	let firstName : String?
	let lastName : String?
	let email : String?
	let mobile : String?
	let talukName : String?
	let masterCustomerUserId : Int?
	let childCustomerUserId : Int?
	let totalPointsEarned : String?
	let totalPointsRedeemed : String?
	let totalEnrollCount : Int?
	let totalTransactionCount : Int?
	let totalRedeemedCount : Int?
	let masterCustomerUser : String?
	let password : String?
	let isActive : Int?
	let customerGrade : String?
	let totalPointsBalance : Int?
	let parentUserId : Int?
	let parentLoyaltyId : String?
	let parentFirstName : String?
	let parentMobileNumber : String?
	let seUserId : Int?
	let seLoyaltyId : String?
	let seFirstName : String?
	let childLoyaltyId : String?
	let childFirstName : String?
	let childMobileNumber : String?
	let customerImage : String?
	let enrollmentDate : String?
	let designationName : String?
	let cityName : String?
	let cust1UserId : Int?
	let cust1FirstName : String?
	let cust2UserId : Int?
	let cust2FirstName : String?
	let addressLatitude : String?
	let addressLongitude : String?
	let address1 : String?
	let address2 : String?
	let cityId : Int?
	let sfaCode : String?
	let customerType : String?
	let lastRedemptionDate : String?
	let lastPurchaseDate : String?

	enum CodingKeys: String, CodingKey {

		case loyaltyID = "loyaltyID"
		case userID = "userID"
		case firstName = "firstName"
		case lastName = "lastName"
		case email = "email"
		case mobile = "mobile"
		case talukName = "talukName"
		case masterCustomerUserId = "masterCustomerUserId"
		case childCustomerUserId = "childCustomerUserId"
		case totalPointsEarned = "totalPointsEarned"
		case totalPointsRedeemed = "totalPointsRedeemed"
		case totalEnrollCount = "totalEnrollCount"
		case totalTransactionCount = "totalTransactionCount"
		case totalRedeemedCount = "totalRedeemedCount"
		case masterCustomerUser = "masterCustomerUser"
		case password = "password"
		case isActive = "isActive"
		case customerGrade = "customerGrade"
		case totalPointsBalance = "totalPointsBalance"
		case parentUserId = "parentUserId"
		case parentLoyaltyId = "parentLoyaltyId"
		case parentFirstName = "parentFirstName"
		case parentMobileNumber = "parentMobileNumber"
		case seUserId = "seUserId"
		case seLoyaltyId = "seLoyaltyId"
		case seFirstName = "seFirstName"
		case childLoyaltyId = "childLoyaltyId"
		case childFirstName = "childFirstName"
		case childMobileNumber = "childMobileNumber"
		case customerImage = "customerImage"
		case enrollmentDate = "enrollmentDate"
		case designationName = "designationName"
		case cityName = "cityName"
		case cust1UserId = "cust1UserId"
		case cust1FirstName = "cust1FirstName"
		case cust2UserId = "cust2UserId"
		case cust2FirstName = "cust2FirstName"
		case addressLatitude = "addressLatitude"
		case addressLongitude = "addressLongitude"
		case address1 = "address1"
		case address2 = "address2"
		case cityId = "cityId"
		case sfaCode = "sfaCode"
		case customerType = "customerType"
		case lastRedemptionDate = "lastRedemptionDate"
		case lastPurchaseDate = "lastPurchaseDate"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		loyaltyID = try values.decodeIfPresent(String.self, forKey: .loyaltyID)
		userID = try values.decodeIfPresent(Int.self, forKey: .userID)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		talukName = try values.decodeIfPresent(String.self, forKey: .talukName)
		masterCustomerUserId = try values.decodeIfPresent(Int.self, forKey: .masterCustomerUserId)
		childCustomerUserId = try values.decodeIfPresent(Int.self, forKey: .childCustomerUserId)
		totalPointsEarned = try values.decodeIfPresent(String.self, forKey: .totalPointsEarned)
		totalPointsRedeemed = try values.decodeIfPresent(String.self, forKey: .totalPointsRedeemed)
		totalEnrollCount = try values.decodeIfPresent(Int.self, forKey: .totalEnrollCount)
		totalTransactionCount = try values.decodeIfPresent(Int.self, forKey: .totalTransactionCount)
		totalRedeemedCount = try values.decodeIfPresent(Int.self, forKey: .totalRedeemedCount)
		masterCustomerUser = try values.decodeIfPresent(String.self, forKey: .masterCustomerUser)
		password = try values.decodeIfPresent(String.self, forKey: .password)
		isActive = try values.decodeIfPresent(Int.self, forKey: .isActive)
		customerGrade = try values.decodeIfPresent(String.self, forKey: .customerGrade)
		totalPointsBalance = try values.decodeIfPresent(Int.self, forKey: .totalPointsBalance)
		parentUserId = try values.decodeIfPresent(Int.self, forKey: .parentUserId)
		parentLoyaltyId = try values.decodeIfPresent(String.self, forKey: .parentLoyaltyId)
		parentFirstName = try values.decodeIfPresent(String.self, forKey: .parentFirstName)
		parentMobileNumber = try values.decodeIfPresent(String.self, forKey: .parentMobileNumber)
		seUserId = try values.decodeIfPresent(Int.self, forKey: .seUserId)
		seLoyaltyId = try values.decodeIfPresent(String.self, forKey: .seLoyaltyId)
		seFirstName = try values.decodeIfPresent(String.self, forKey: .seFirstName)
		childLoyaltyId = try values.decodeIfPresent(String.self, forKey: .childLoyaltyId)
		childFirstName = try values.decodeIfPresent(String.self, forKey: .childFirstName)
		childMobileNumber = try values.decodeIfPresent(String.self, forKey: .childMobileNumber)
		customerImage = try values.decodeIfPresent(String.self, forKey: .customerImage)
		enrollmentDate = try values.decodeIfPresent(String.self, forKey: .enrollmentDate)
		designationName = try values.decodeIfPresent(String.self, forKey: .designationName)
		cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
		cust1UserId = try values.decodeIfPresent(Int.self, forKey: .cust1UserId)
		cust1FirstName = try values.decodeIfPresent(String.self, forKey: .cust1FirstName)
		cust2UserId = try values.decodeIfPresent(Int.self, forKey: .cust2UserId)
		cust2FirstName = try values.decodeIfPresent(String.self, forKey: .cust2FirstName)
		addressLatitude = try values.decodeIfPresent(String.self, forKey: .addressLatitude)
		addressLongitude = try values.decodeIfPresent(String.self, forKey: .addressLongitude)
		address1 = try values.decodeIfPresent(String.self, forKey: .address1)
		address2 = try values.decodeIfPresent(String.self, forKey: .address2)
		cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
		sfaCode = try values.decodeIfPresent(String.self, forKey: .sfaCode)
		customerType = try values.decodeIfPresent(String.self, forKey: .customerType)
		lastRedemptionDate = try values.decodeIfPresent(String.self, forKey: .lastRedemptionDate)
		lastPurchaseDate = try values.decodeIfPresent(String.self, forKey: .lastPurchaseDate)
	}

}
