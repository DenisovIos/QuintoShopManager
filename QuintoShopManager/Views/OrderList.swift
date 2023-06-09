//
//  OrderList.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import SwiftUI

struct OrderList: View {
    
    var body: some View {
        VStack{
            Button("2weqe") {
                Task{
                    try await FirestoreService.shared.supportMethod()
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
