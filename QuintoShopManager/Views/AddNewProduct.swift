//
//  AddNewProduct.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import SwiftUI

struct AddNewProduct: View {
    @StateObject var viewModel = AddNewProductViewModel()
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Название: ")
                TextField("", text: $viewModel.name)
            }
            VStack {
                Text("Описание: ")
                TextField("", text: $viewModel.description)
            }
            HStack{
                Text("Цена: ")
                TextField("", text: $viewModel.price)
                 
            }
            HStack{
                Text("Артикуль: ")
                TextField("", text: $viewModel.article)
            }
            Picker("Фильтр", selection: $viewModel.type) {
                ForEach(viewModel.productTypeList) {
                    product in
                    Text(product.title)
                        .tag(product)
                }
                .pickerStyle(.inline)
            }
        }
       
    }
}

struct AddNewProduct_Previews: PreviewProvider {
    static var previews: some View {
        AddNewProduct()
    }
}
