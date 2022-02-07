import Foundation
struct Info : Codable {
	let year : Int?
	let contributor : String?
	let dateCreated : String?
	let url : String?
	let description : String?
	let version : String?

	enum CodingKeys: String, CodingKey {

		case year = "year"
		case contributor = "contributor"
		case dateCreated = "date_created"
		case url = "url"
		case description = "description"
		case version = "version"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		year = try values.decodeIfPresent(Int.self, forKey: .year)
		contributor = try values.decodeIfPresent(String.self, forKey: .contributor)
		dateCreated = try values.decodeIfPresent(String.self, forKey: .dateCreated)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		version = try values.decodeIfPresent(String.self, forKey: .version)
	}

}
