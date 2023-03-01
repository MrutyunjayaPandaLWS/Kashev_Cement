/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstTaluk : Codable {
	let talukId : Int?
	let talukName : String?
	let talukCode : String?
	let districtId : Int?
	let stateId : Int?
	let isActive : Bool?
	let talukCityMappingId : Int?
	let talukCityId : Int?
	let row : Int?

	enum CodingKeys: String, CodingKey {

		case talukId = "talukId"
		case talukName = "talukName"
		case talukCode = "talukCode"
		case districtId = "districtId"
		case stateId = "stateId"
		case isActive = "isActive"
		case talukCityMappingId = "talukCityMappingId"
		case talukCityId = "talukCityId"
		case row = "row"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		talukId = try values.decodeIfPresent(Int.self, forKey: .talukId)
		talukName = try values.decodeIfPresent(String.self, forKey: .talukName)
		talukCode = try values.decodeIfPresent(String.self, forKey: .talukCode)
		districtId = try values.decodeIfPresent(Int.self, forKey: .districtId)
		stateId = try values.decodeIfPresent(Int.self, forKey: .stateId)
		isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
		talukCityMappingId = try values.decodeIfPresent(Int.self, forKey: .talukCityMappingId)
		talukCityId = try values.decodeIfPresent(Int.self, forKey: .talukCityId)
		row = try values.decodeIfPresent(Int.self, forKey: .row)
	}

}