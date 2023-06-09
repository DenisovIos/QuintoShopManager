//
//  ContentView.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import SwiftUI

struct ProductList: View {
    @StateObject var viewModel = ProductViewModel()
    var body: some View {
        VStack {
            VStack{
                Text("Список товаров")
                HStack{
                    Picker("Фильтр", selection: $viewModel.choosedFilter) {
                        ForEach(viewModel.productTypeList) {
                            product in
                            Text(product.title)
                                .tag(product)
                        }
                    }
                    Button {
                        print(viewModel.choosedFilter.title)
                    } label: {
                       Text("Применить фильтр")
                    }
                    .background(.green)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

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
