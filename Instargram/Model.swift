//
//  Model.swift
//  Instargram
//
//  Created by Lee on 2023/09/13.
//


import UIKit

struct List: Codable {
    var id: UUID = UUID()
    var title: String
    var date: Date?
    var isCompleted: Bool
}

struct CompleteList: Codable {
    var title: String
    var date: Date?
}

struct Profile: Codable {
    var userAge: Int
    var password: String
    var nickName: String
    var image: String
}

