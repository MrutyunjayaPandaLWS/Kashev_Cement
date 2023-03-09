
import Foundation
struct CityListModels : Codable {
    let cityList : [CityList]?
    let returnValue : Int?
    let returnMessage : String?
    let totalRecords : Int?

    enum CodingKeys: String, CodingKey {

        case cityList = "cityList"
        case returnValue = "returnValue"
        case returnMessage = "returnMessage"
        case totalRecords = "totalRecords"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cityList = try values.decodeIfPresent([CityList].self, forKey: .cityList)
        returnValue = try values.decodeIfPresent(Int.self, forKey: .returnValue)
        returnMessage = try values.decodeIfPresent(String.self, forKey: .returnMessage)
        totalRecords = try values.decodeIfPresent(Int.self, forKey: .totalRecords)
    }

}

