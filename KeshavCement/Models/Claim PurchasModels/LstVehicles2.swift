/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstVehicles2 : Codable {
	let slNo : String?
	let result : String?
	let remarks : String?
	let vehicleNumber : String?
	let vehicleType : String?
	let mobile : String?
	let vinchasis : String?
	let firstName : String?
	let pointBalance : String?
	let pointCredited : String?

	enum CodingKeys: String, CodingKey {

		case slNo = "slNo"
		case result = "result"
		case remarks = "remarks"
		case vehicleNumber = "vehicleNumber"
		case vehicleType = "vehicleType"
		case mobile = "mobile"
		case vinchasis = "vinchasis"
		case firstName = "firstName"
		case pointBalance = "pointBalance"
		case pointCredited = "pointCredited"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		slNo = try values.decodeIfPresent(String.self, forKey: .slNo)
		result = try values.decodeIfPresent(String.self, forKey: .result)
		remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
		vehicleNumber = try values.decodeIfPresent(String.self, forKey: .vehicleNumber)
		vehicleType = try values.decodeIfPresent(String.self, forKey: .vehicleType)
		mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
		vinchasis = try values.decodeIfPresent(String.self, forKey: .vinchasis)
		firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
		pointBalance = try values.decodeIfPresent(String.self, forKey: .pointBalance)
		pointCredited = try values.decodeIfPresent(String.self, forKey: .pointCredited)
	}

}
