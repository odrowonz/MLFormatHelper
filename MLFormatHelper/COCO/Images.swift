import Foundation
struct Images : Codable {
	let dateCaptured : String?
	let height : Int?
	let id : Int
	let width : Int?
	let fileName : String
	let cocoUrl : String?
	let license : Int?

	enum CodingKeys: String, CodingKey {

		case dateCaptured = "date_captured"
		case height = "height"
		case id = "id"
		case width = "width"
		case fileName = "file_name"
		case cocoUrl = "coco_url"
		case license = "license"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dateCaptured = try values.decodeIfPresent(String.self, forKey: .dateCaptured)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		id = try values.decode(Int.self, forKey: .id)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
		fileName = try values.decode(String.self, forKey: .fileName)
		cocoUrl = try values.decodeIfPresent(String.self, forKey: .cocoUrl)
		license = try values.decodeIfPresent(Int.self, forKey: .license)
	}
}
