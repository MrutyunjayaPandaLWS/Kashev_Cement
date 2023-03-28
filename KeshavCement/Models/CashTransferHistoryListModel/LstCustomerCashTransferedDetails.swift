/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstCustomerCashTransferedDetails : Codable {
	let customerName : String?
	let cashTransferId : Int?
	let customerMobile : String?
	let loyaltyId : String?
	let createdDate : String?
	let customerType : String?
	let locationName : String?
	let transferedPointsinAmount : Int?
	let points : Int?
	let dispalyImage : String?
	let remarks : String?
	let cashTransferedStatus : String?

	enum CodingKeys: String, CodingKey {

		case customerName = "customerName"
		case cashTransferId = "cashTransferId"
		case customerMobile = "customerMobile"
		case loyaltyId = "loyaltyId"
		case createdDate = "createdDate"
		case customerType = "customerType"
		case locationName = "locationName"
		case transferedPointsinAmount = "transferedPointsinAmount"
		case points = "points"
		case dispalyImage = "dispalyImage"
		case remarks = "remarks"
		case cashTransferedStatus = "cashTransferedStatus"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		customerName = try values.decodeIfPresent(String.self, forKey: .customerName)
		cashTransferId = try values.decodeIfPresent(Int.self, forKey: .cashTransferId)
		customerMobile = try values.decodeIfPresent(String.self, forKey: .customerMobile)
		loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
		createdDate = try values.decodeIfPresent(String.self, forKey: .createdDate)
		customerType = try values.decodeIfPresent(String.self, forKey: .customerType)
		locationName = try values.decodeIfPresent(String.self, forKey: .locationName)
		transferedPointsinAmount = try values.decodeIfPresent(Int.self, forKey: .transferedPointsinAmount)
		points = try values.decodeIfPresent(Int.self, forKey: .points)
		dispalyImage = try values.decodeIfPresent(String.self, forKey: .dispalyImage)
		remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
		cashTransferedStatus = try values.decodeIfPresent(String.self, forKey: .cashTransferedStatus)
	}

}