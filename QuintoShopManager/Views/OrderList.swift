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
                print("1212")
            }
            if images.count > 0 {
                Image(uiImage: images[0])
            } else {
                Image(uiImage: UIImage(systemName: "person")!)
            }
            Button("Get photo") {
                Task {
                   
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
