/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct ClaimPurchaseSubmissionModel : Codable {
	let firstName : String?
	let mobile : String?
	let creditedPoints : Int?
	let pointsBalance : Int?
	let lstVehicles : String?
	let objProductFileStatus : String?
	let returnValue : Int?
	let returnMessage : String?

	enum CodingKeys: String, CodingKey {

		case firstName = "firstName"
		case mobile = "mobile"
		case creditedPoints = "creditedPoints"
		case pointsBalance = "pointsBalance"
		case lstVehicles = "lstVehicles"
		case objProductFileStatus = "objProductFileStatus"
		case returnValue = "returnValue"
		case returnMessage = "returnMessage"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		creditedPoints = try values.decodeIfPresent(Int.self, forKey: .creditedPoints)
		pointsBalance = try values.decodeIfPresent(Int.self, forKey: .pointsBalance)
		lstVehicles = try values.decodeIfPresent(String.self, forKey: .lstVehicles)
		objProductFileStatus = try values.decodeIfPresent(String.self, forKey: .objProductFileStatus)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
	}

}
