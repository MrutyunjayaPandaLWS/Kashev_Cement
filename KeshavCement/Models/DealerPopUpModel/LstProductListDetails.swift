/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct LstProductListDetails : Codable {
	let productId : Int?
	let productName : String?
	let productCode : String?
	let productDesc : String?
	let brandId : Int?
	let brandName : String?
	let brandCode : String?
	let brandDesc : String?
	let imageUrl : String?
	let productShortDesc : String?
	let productImage : String?
	let categoryId : Int?
	let categoryName : String?
	let categoryDesc : String?
	let categoryImg : String?
	let quantity : String?

	enum CodingKeys: String, CodingKey {

		case productId = "productId"
		case productName = "productName"
		case productCode = "productCode"
		case productDesc = "productDesc"
		case brandId = "brandId"
		case brandName = "brandName"
		case brandCode = "brandCode"
		case brandDesc = "brandDesc"
		case imageUrl = "imageUrl"
		case productShortDesc = "productShortDesc"
		case productImage = "productImage"
		case categoryId = "categoryId"
		case categoryName = "categoryName"
		case categoryDesc = "categoryDesc"
		case categoryImg = "categoryImg"
		case quantity = "quantity"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		productId = try values.decodeIfPresent(Int.self, forKey: .productId)
		productName = try values.decodeIfPresent(String.self, forKey: .productName)
		productCode = try values.decodeIfPresent(String.self, forKey: .productCode)
		productDesc = try values.decodeIfPresent(String.self, forKey: .productDesc)
		brandId = try values.decodeIfPresent(Int.self, forKey: .brandId)
		brandName = try values.decodeIfPresent(String.self, forKey: .brandName)
		brandCode = try values.decodeIfPresent(String.self, forKey: .brandCode)
		brandDesc = try values.decodeIfPresent(String.self, forKey: .brandDesc)
		imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
		productShortDesc = try values.decodeIfPresent(String.self, forKey: .productShortDesc)
		productImage = try values.decodeIfPresent(String.self, forKey: .productImage)
		categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
		categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
		categoryDesc = try values.decodeIfPresent(String.self, forKey: .categoryDesc)
		categoryImg = try values.decodeIfPresent(String.self, forKey: .categoryImg)
		quantity = try values.decodeIfPresent(String.self, forKey: .quantity)
	}

}