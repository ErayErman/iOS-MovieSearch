
import Foundation


struct Film: Decodable {
    let title: String
    let imdbID: String
    let director: String?
    let plot: String?
    let posterURL: String
    let year: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case imdbID = "imdbID"
        case director = "Director"
        case plot = "Plot"
        case posterURL = "Poster"
        case year = "Year"
    }
}


struct Films: Decodable {
    let all: [Film]
    
    enum CodingKeys: String, CodingKey {
        case all = "Search"
    }
}

protocol Displayable {
    var titleLabelText: String { get }
    var imdbIDText: String { get }
    var directorLabelText: String? { get }
    var plotLabelText: String? { get }
    var posterURLLabelText: String { get }
    var yearLabelText: String { get }
}



extension Film: Displayable {
    var titleLabelText: String { title }
    var imdbIDText: String { imdbID }
    var directorLabelText: String? { "Director: " + director! }
    var plotLabelText: String? { plot }
    var posterURLLabelText: String { posterURL }
    var yearLabelText: String { year }
}


