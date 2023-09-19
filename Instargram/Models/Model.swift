//
//  Model.swift
//  Instargram
//
//  Created by Lee on 2023/09/13.
//


import Foundation

struct List: Codable{
    var id: UUID = UUID()
    var title: String
    var date: Date?
    var isCompleted: Bool
    var section: String
}

struct CompleteList: Codable {
    var title: String
    var date: Date?
    var section: String

}

struct Profile {
    var userAge: Int
    var userName: String
}

enum Section: String, CaseIterable {
    case none = "None"
    case study = "Study"
    case hobby = "Hobby"
}
