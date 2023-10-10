import Foundation

/// A struct containing an array of national park codes.
///
/// The NationalParks API didnt have a good way to query just the national parks so i used the `parkCodes`
/// query param to get the parks I wanted for the app.
///
struct ParkCodes {
    static let nationalParks: [String] = [
        "acad", "arch", "badl", "zion", "npsa", "badl", "yell", "grca", "romo", "grte",
        "yose", "indu", "glac", "jotr", "olym", "cuva", "hosp", "brca", "neri", "mora",
        "shen", "care", "havo", "deva", "jeff", "sagu", "seki", "ever", "cany", "hale",
        "thro", "whsa", "wica", "bisc", "crla", "grsa", "pefo", "bibe", "meve", "maca",
        "redw", "kefj", "lavo", "cave", "pinn", "viis", "chis", "blca", "gumo", "voya",
        "dena", "cong", "grba", "glba", "drto", "wrst", "isro", "katm", "lacl", "noca",
        "kova", "gaar"
    ]
}
