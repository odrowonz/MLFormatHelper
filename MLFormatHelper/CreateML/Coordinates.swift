import Foundation
struct Coordinates : Codable {
    let x : Int
    let y : Int
    let width : Int
	let height : Int
	
	enum CodingKeys: String, CodingKey {
        case x = "x"
		case y = "y"
		case width = "width"
        case height = "height"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        x = try values.decode(Int.self, forKey: .x)
		y = try values.decode(Int.self, forKey: .y)
        width = try values.decode(Int.self, forKey: .width)
		height = try values.decode(Int.self, forKey: .height)
	}
    
    init(x xx: Int, y yy: Int, width ww: Int, height hh: Int) {
        x = xx
        y = yy
        width = ww
        height = hh
    }
}
