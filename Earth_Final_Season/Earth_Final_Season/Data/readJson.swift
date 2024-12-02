//
//  readJson.swift
//  Earth_Final_Season
//
//  Created by Larissa Okabayashi on 26/09/24.
//

import Foundation

func readLocalJSONFile(forName name: String) -> Data? {
    do {
       if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
           let fileUrl = URL(fileURLWithPath: filePath)
           let data = try Data(contentsOf: fileUrl)
           return data
       }
   } catch {
       print("error: \(error)")
   }
   return nil
}

// Define a top-level struct to match JSON format
struct sampleRecord: Codable {
    let mockEvents: [Event]
}

// Parse the JSON data into your Swift structs
func parse(jsonData: Data) -> [Event]? {
    do {
        var decodedData = try JSONDecoder().decode(sampleRecord.self, from: jsonData)
        return decodedData.mockEvents
    } catch {
        print("Error parsing JSON: \(error)")
    }
    return nil
}

func loadAndReturnEvents(isPortuguese: Bool) -> [Event] {
    let jsonFileName = isPortuguese ? "EventsDataBR" : "EventsData"
    if let jsonData = readLocalJSONFile(forName: jsonFileName) {
        if let eventsData = parse(jsonData: jsonData) {
            return eventsData
        } else {
            print("Failed to parse JSON.")
        }
    } else {
        print("Failed to load JSON file.")
    }
    return []
}
