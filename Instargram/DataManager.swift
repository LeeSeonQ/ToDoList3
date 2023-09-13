//
//  File.swift
//  Instargram
//
//  Created by Lee on 2023/09/13.
//

import Foundation


final class DataManager {
    private static let listKey = "ListKey"
    private static let profileKey = "ProfileKey"
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults.standard
    
    func saveList(_ list: [List]) {
        let encodedData = try? JSONEncoder().encode(list)
        userDefaults.set(encodedData, forKey: DataManager.listKey)
    }
    
    func loadList() -> [List]? {
        if let encodedData = userDefaults.data(forKey: DataManager.listKey),
           let list = try? JSONDecoder().decode([List].self, from: encodedData) {
            return list
        }
        return nil
    }
    
    func deleteList(at index: Int) {
        var lists = loadList() ?? []
        lists.remove(at: index)
        saveList(lists)
    }
    
    func updateList(at index: Int, with updatedList: List) {
        let lists = loadList()
        if var lists = lists, index >= 0 && index < lists.count {
            lists[index] = updatedList
            saveList(lists)
        }
    }
    
    func saveProfile(_ profile: Profile) {
        let encodedData = try? JSONEncoder().encode(profile)
        userDefaults.set(encodedData, forKey: DataManager.profileKey)
    }
    
    func loadProfile() -> Profile? {
        if let encodedData = userDefaults.data(forKey: DataManager.profileKey),
           let profile = try? JSONDecoder().decode(Profile.self, from: encodedData) {
            return profile
        }
        return nil
    }
    
}
