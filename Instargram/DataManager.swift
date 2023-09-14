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
    private static let completeListsKey = "CompleteListsKey"

    static let shared = DataManager()
    
    private let userDefaults = UserDefaults.standard
    
    private var completeList: [CompleteList] = []

    func saveList(_ list: [List]) {
        let encodedData = try? JSONEncoder().encode(list)
        userDefaults.set(encodedData, forKey: DataManager.listKey)
    }
    
    func saveCompleteList(_ list: CompleteList) {
         completeList.append(list)
         saveCompleteLists()
     }
    
    private func saveCompleteLists() {
        let encodedData = try? JSONEncoder().encode(completeList)
        userDefaults.set(encodedData, forKey: DataManager.completeListsKey)
    }
    
    func loadList() -> [List]? {
        if let encodedData = userDefaults.data(forKey: DataManager.listKey),
           let list = try? JSONDecoder().decode([List].self, from: encodedData) {
            return list
        }
        return nil
    }
    
    func loadCompleteList() -> [CompleteList] {
        if let encodedData = userDefaults.data(forKey: DataManager.completeListsKey),
           let items = try? JSONDecoder().decode([CompleteList].self, from: encodedData) {
            return items
        }
        return []
    }
    
    func deleteList(at index: Int) {
        var lists = loadList() ?? []
        lists.remove(at: index)
        saveList(lists)
    }
    
    func deleteCompleteList(_ list: CompleteList) {
        if let index = completeList.firstIndex(where: { $0.title == list.title }) {
            completeList.remove(at: index)
            saveCompleteLists()
        }
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
