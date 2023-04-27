

import Foundation
struct NotificationModels : Codable {
    let lstPushHistory : String?
    let lstPushHistoryJson : [LstPushHistoryJson]?
    let returnValue : Int?
    let returnMessage : String?
    let totalRecords : Int?

    enum CodingKeys: String, CodingKey {

        case lstPushHistory = "lstPushHistory"
        case lstPushHistoryJson = "lstPushHistoryJson"
        case returnValue = "returnValue"
        case returnMessage = "returnMessage"
        case totalRecords = "totalRecords"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lstPushHistory = try values.decodeIfPresent(String.self, forKey: .lstPushHistory)
        lstPushHistoryJson = try values.decodeIfPresent([LstPushHistoryJson].self, forKey: .lstPushHistoryJson)
        returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
        returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
        totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
    }

}
