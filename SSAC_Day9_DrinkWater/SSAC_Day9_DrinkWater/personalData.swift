//
//  personalData.swift
//  SSAC_Day9_DrinkWater
//
//  Created by 최혜린 on 2021/10/08.
//

import Foundation

struct Person: Codable {
    var name: String
    var height: Double
    var weight: Double
    var currentDrankWater: Double = 0
    var totalWater: Double
}

class dataManager {
    static let shared = dataManager()
    
    let defaultPerson: Person = Person(name: "익명의 고양이", height: 160, weight: 50, currentDrankWater: 0, totalWater: (160 + 50) / 100)
    
    func saveData(name: String, height: Double, weight: Double, person: Person) {
        let defaults = UserDefaults.standard
        let revisedData = Person(name: name, height: height, weight: weight, currentDrankWater: person.currentDrankWater, totalWater: (height + weight) / 100)
        defaults.setValue(try? PropertyListEncoder().encode(revisedData), forKey: "data")
    }
    
    func updateWater(person: Person, water: Double) {
        let defaults = UserDefaults.standard
        let revisedData = Person(name: person.name, height: person.height, weight: person.weight, currentDrankWater: water, totalWater: person.totalWater)
        defaults.setValue(try? PropertyListEncoder().encode(revisedData), forKey: "data")
    }
    
    func retrieveData() -> Person {
        if let savedData = UserDefaults.standard.value(forKey: "data") as? Data {
            let personalData = try? PropertyListDecoder().decode(Person.self, from: savedData)
            return personalData ?? defaultPerson
        } else {
            return defaultPerson
        }
    }
    
    func resetData(person: Person) {
        let defaults = UserDefaults.standard
        let revisedData = Person(name: person.name, height: person.height, weight: person.weight, currentDrankWater: 0, totalWater: person.totalWater)
        defaults.setValue(try? PropertyListEncoder().encode(revisedData), forKey: "data")
    }
}

class dataViewModel {
    private let manager = dataManager.shared

    var personInfo: Person?
    
    func save(name: String, height: Double, weight: Double, person: Person) {
        manager.saveData(name: name, height: height, weight: weight, person: person)
    }
    
    func update(person: Person, water: Double) {
        manager.updateWater(person: person, water: water)
    }
    
    func loadData() -> Person {
        return manager.retrieveData()
    }
    
    func reset(person: Person) {
        manager.resetData(person: person)
    }
}
