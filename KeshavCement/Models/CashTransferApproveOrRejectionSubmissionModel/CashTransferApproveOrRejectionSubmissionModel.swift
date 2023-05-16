/*
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct CashTransferApproveOrRejectionSubmissionModel : Codable {
    let returnMessage : String?
    let returnValue : Int?
    let redeemablePointBalance : Int?
    let lstCashTransfer : String?
    let lstCustomerCashTransferedDetails : String?
    let loyaltyId : String?
    let mobile : String?
    let pointsCredited : Int?
    let pointBalance : Int?
    let firstName : String?

    enum CodingKeys: String, CodingKey {

        case returnMessage = "returnMessage"
        case returnValue = "returnValue"
        case redeemablePointBalance = "redeemablePointBalance"
        case lstCashTransfer = "lstCashTransfer"
        case lstCustomerCashTransferedDetails = "lstCustomerCashTransferedDetails"
        case loyaltyId = "loyaltyId"
        case mobile = "mobile"
        case pointsCredited = "pointsCredited"
        case pointBalance = "pointBalance"
        case firstName = "firstName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
        returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
        redeemablePointBalance = try values.decodeIfPresent(Int.self, forKey: .redeemablePointBalance)
        lstCashTransfer = try values.decodeIfPresent(String.self, forKey: .lstCashTransfer)
        lstCustomerCashTransferedDetails = try values.decodeIfPresent(String.self, forKey: .lstCustomerCashTransferedDetails)
        loyaltyId = try values.decodeIfPresent(String.self, forKey: .loyaltyId)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        pointsCredited = try values.decodeIfPresent(Int.self, forKey: .pointsCredited)
        pointBalance = try values.decodeIfPresent(Int.self, forKey: .pointBalance)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
    }

}
