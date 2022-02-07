import Foundation
struct CMLFormat : Codable {
	let annotation : [Annotation]?
	let images : String?

	enum CodingKeys: String, CodingKey {

		case annotation = "annotation"
		case images = "images"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		annotation = try values.decodeIfPresent([Annotation].self, forKey: .annotation)
		images = try values.decodeIfPresent(String.self, forKey: .images)
	}
    
    init(annotation ann: [Annotation]?, images img: String?) {
        annotation = ann
        images = img
    }

}
