//
//  OrderList.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import SwiftUI

struct OrderList: View {
    @State var images = [UIImage]()
    var body: some View {
        VStack{
            Button("12312") {
                StorageManager.shared.uploadImage([UIImage(systemName: "person")!], "12312")
            }
            if images.count > 0 {
                Image(uiImage: images[0])
            } else {
                Image(uiImage: UIImage(systemName: "person")!)
            }
            Button("Get photo") {
                Task {
                    print("yачинаем загружать фотку")
                    let images = try await StorageManager.shared.downloadImages("12312")
                    print("не дожидается тут и хоть тресни")
                    DispatchQueue.main.async {
                        print("дада, пошел я нахер")
                        self.images = images
                    }
                    
                }
            }
        }
    }
}

struct OrderList_Previews: PreviewProvider {
    static var previews: some View {
        OrderList()
    }
}
