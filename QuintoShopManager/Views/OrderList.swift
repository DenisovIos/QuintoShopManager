//
//  OrderList.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import SwiftUI

struct OrderList: View {
    @State var image = UIImage(systemName: "person")!
    var body: some View {
        VStack{
            Button("12312") {
                StorageManager.shared.uploadImage([UIImage(systemName: "person")!], "12312")
            }
            Image(uiImage: image)
            Button("Get photo") {
                Task {
                    print("yачинаем загружать фотку")
                    let images = try await StorageManager.shared.downloadImages("12312")
                }
            }
        }
    }
    func changeImage(_ image : UIImage ) async throws {
        self.image = image
    }
}

struct OrderList_Previews: PreviewProvider {
    static var previews: some View {
        OrderList()
    }
}
