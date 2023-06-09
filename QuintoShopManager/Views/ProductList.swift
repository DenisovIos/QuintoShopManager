//
//  ContentView.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import SwiftUI

struct ProductList: View {
    var body: some View {
        VStack {
            VStack{
                Text("Список товаров")
                Picker("Фильтр", selection: <#T##Binding<Hashable>#>) { 
                    <#code#>
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductList()
    }
}
