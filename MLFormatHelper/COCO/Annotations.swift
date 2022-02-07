import Foundation
struct Annotations : Codable {
	let id : Int
	let imageId : Int
	let categoryId : Int?
	let bbox : [Int]?

	enum CodingKeys: String, CodingKey {
		case id = "id"
		case imageId = "image_id"
		case categoryId = "category_id"
		case bbox = "bbox"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decode(Int.self, forKey: .id)
		imageId = try values.decode(Int.self, forKey: .imageId)
		categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
		bbox = try values.decodeIfPresent([Int].self, forKey: .bbox)
	}
}
