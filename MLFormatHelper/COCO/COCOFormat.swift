import Foundation
struct COCOFormat : Codable {
	let licenses : [Licenses]?
	let annotations : [Annotations]?
	let info : Info?
	let categories : [Categories]?
	let images : [Images]?

	enum CodingKeys: String, CodingKey {

		case licenses = "licenses"
		case annotations = "annotations"
		case info = "info"
		case categories = "categories"
		case images = "images"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		licenses = try values.decodeIfPresent([Licenses].self, forKey: .licenses)
		annotations = try values.decodeIfPresent([Annotations].self, forKey: .annotations)
		info = try values.decodeIfPresent(Info.self, forKey: .info)
		categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
		images = try values.decodeIfPresent([Images].self, forKey: .images)
	}

}
