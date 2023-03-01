/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct RedemptionSubmissionModel : Codable {
	let pdfLink : String?
	let uniqueID : String?
	let userId : Int?
	let responseCode : String?
	let membershipID : String?
	let redemptionReferenceNumber : String?
	let redemptionStatus : String?
	let objCatalogueList : String?
	let returnValue : Int?
	let returnMessage : String?
	let totalRecords : Int?

	enum CodingKeys: String, CodingKey {

		case pdfLink = "pdfLink"
		case uniqueID = "uniqueID"
		case userId = "userId"
		case responseCode = "responseCode"
		case membershipID = "membershipID"
		case redemptionReferenceNumber = "redemptionReferenceNumber"
		case redemptionStatus = "redemptionStatus"
		case objCatalogueList = "objCatalogueList"
		case returnValue = "returnValue"
		case returnMessage = "returnMessage"
		case totalRecords = "totalRecords"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		pdfLink = try values.decodeIfPresent(String.self, forKey: .pdfLink)
		uniqueID = try values.decodeIfPresent(String.self, forKey: .uniqueID)
		userId = try values.decodeIfPresent(Int.self, forKey: .userId)
		responseCode = try values.decodeIfPresent(String.self, forKey: .responseCode)
		membershipID = try values.decodeIfPresent(String.self, forKey: .membershipID)
		redemptionReferenceNumber = try values.decodeIfPresent(String.self, forKey: .redemptionReferenceNumber)
		redemptionStatus = try values.decodeIfPresent(String.self, forKey: .redemptionStatus)
		objCatalogueList = try values.decodeIfPresent(String.self, forKey: .objCatalogueList)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
	}

}
