//
//  ContentView.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import SwiftUI

struct ProductList: View {
    @StateObject var viewModel = ProductListViewModel()
    var body: some View {
        VStack {
            VStack{
                Text("Список товаров")
                    .font(.title)
                HStack{
                    TextField("Поиск по артиклу", text: $viewModel.searchArticle)
                    Button {
                        print("поиск по артиклу")
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }

                }
                .frame(height: 30)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(lineWidth: 1)
                        .foregroundColor(.gray)
                }.padding(10)
                
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
                    Text("Тут будут товары")
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
