

import Foundation
struct NotificationModels : Codable {
	let returnMessage : String?
	let returnValue : Int?
	let totalRecords : Int?
	let lstPushHistory : String?
	let lstPushHistoryJson : [LstPushHistoryJson]?

	enum CodingKeys: String, CodingKey {

		case returnMessage = "ReturnMessage"
		case returnValue = "ReturnValue"
		case totalRecords = "TotalRecords"
		case lstPushHistory = "lstPushHistory"
		case lstPushHistoryJson = "lstPushHistoryJson"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
		returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
		totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
		lstPushHistory = try values.decodeIfPresent(String.self, forKey: .lstPushHistory)
		lstPushHistoryJson = try values.decodeIfPresent([LstPushHistoryJson].self, forKey: .lstPushHistoryJson)
	}

}
