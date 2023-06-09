//
//  TabBarView.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView{
            ProductList()
                .tabItem {
                    VStack{
                        Image(systemName: "menucard")
                        Text("Список товаров")
                    }
                }
            AddNewProduct()
                .tabItem {
                    VStack{
                        Image(systemName: "plus.circle")
                        Text("Добавить новый товар")
                    }
                }
            OrderList()
                .tabItem {
                    VStack{
                        Image(systemName: "basket")
                        Text("Список заказов")
                    }
                }
            
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
