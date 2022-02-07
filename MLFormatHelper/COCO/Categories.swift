import Foundation
struct Categories : Codable {
	let id : Int
	let name : String

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(Int.self, forKey: .id)
		name = try values.decode(String.self, forKey: .name)
	}

}
