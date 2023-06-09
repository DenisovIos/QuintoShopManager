//
//  TypeOfModel.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import Foundation

struct TypeOfModel: Identifiable {
    var id: String = UUID().uuidString
    var title: String
}


extension TypeOfModel {
   static let dataSource: [TypeOfModel] = [
        TypeOfModel(title: "Микрофоны"),
        TypeOfModel(title: "Комбоусилители"),
        TypeOfModel(title: "Кабели"),
        TypeOfModel(title: "Ударные"),
        TypeOfModel(title: "Струны"),
        TypeOfModel(title: "Аксессуары"),
        TypeOfModel(title: "Клавишные"),
        TypeOfModel(title: "Духовые"),
        TypeOfModel(title: "Народные"),
        TypeOfModel(title: "Смычковые"),
        TypeOfModel(title: "Гитары")
    ]
}
extension TypeOfModel: Hashable {}

extension TypeOfModel {
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["title"] = title
        return repres
    }
}
