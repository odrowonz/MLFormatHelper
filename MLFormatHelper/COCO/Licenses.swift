import Foundation
struct Licenses : Codable {
	let url : String?
	let id : Int?
	let name : String?

	enum CodingKeys: String, CodingKey {

		case url = "url"
		case id = "id"
		case name = "name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
	}

}
