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
                    .font(.title)
                
                HStack(spacing: 0){
                    Spacer()
                    ZStack{
                        Rectangle().strokeBorder()
                            .foregroundColor(.gray)
                        Picker("Фильтр", selection: $viewModel.choosedFilter) {
                            ForEach(viewModel.productTypeList) {
                                product in
                                Text(product.title)
                                    .tag(product)
                            }
                            .pickerStyle(.inline)
                        }
                    }
                    .frame(height: 40)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Button {
                        print(viewModel.choosedFilter.title)
                    } label: {
                        Text("Применить фильтр")
                    }
                    .padding(.horizontal, 10)
                    .frame(height: 40)
                    .background(.gray)
                    .foregroundColor(.black)
                }
                .padding()
                .background(.white)
                .frame(height: 40)
                List {
                    Text("1")
                }
                .listStyle(.plain)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductList()
    }
}
