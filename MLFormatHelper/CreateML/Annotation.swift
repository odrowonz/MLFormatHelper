import Foundation
struct Annotation : Codable {
	let coordinates : Coordinates?
	let label : String?

	enum CodingKeys: String, CodingKey {
		case coordinates = "coordinates"
		case label = "label"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		coordinates = try values.decodeIfPresent(Coordinates.self, forKey: .coordinates)
		label = try values.decodeIfPresent(String.self, forKey: .label)
	}
    
    init(coordinates coords: Coordinates?, label lbl: String?) {
        coordinates = coords
        label = lbl
    }
}
