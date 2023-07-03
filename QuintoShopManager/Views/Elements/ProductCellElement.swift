//
//  ProductCellElement.swift
//  QuintoShopManager
//
//  Created by Руслан on 03.07.2023.
//

import SwiftUI

struct ProductCellElement: View {
    @StateObject var viewModel = ProductCellElemtViewModel()
    var product: ProductModel

    var body: some View {
        HStack {
            HStack {
                if viewModel.photos.count > 0 {
                    TabView {
                        ForEach(viewModel.photos, id: \.self) { photo in
                            Image(uiImage: photo)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity,
                                       maxHeight: .infinity)
                                .clipped()
                        }
                    }.padding(5)
                        .tabViewStyle(.page)
                } else {
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity)
                        .clipped()
                }
            }.frame(width: 100, height: 100)
            HStack {
                VStack (alignment: .leading, spacing: 5) {
                    Text("Название: ")
                    Text("Цена: ")
                    Text("Артикул: ")
                }
                VStack (alignment: .leading, spacing: 5) {
                    Text(viewModel.product.name)
                    Text(viewModel.product.price)
                    Text(viewModel.product.article)
                }
            }
            .onAppear{
                viewModel.product = product
                Task {
                    try await viewModel.GetImages()
                }
            }
            .frame(width: 200)
            .padding(.horizontal, 5)
            ZStack{
                Rectangle()
                    .foregroundColor(.blue)
                    .cornerRadius(5)
                VStack{
                    Text("Кол-во")
                        .font(.system(size: 10))
                    Text(viewModel.product.quantity)
                        .font(.system(size: 50))
                }
            }
            .frame(width: 50, height: 100)
            
        }
        .padding(.horizontal, 5)
        .frame(height: 100)
        .frame(maxWidth: .infinity)
           
    }
    init(_ product: ProductModel) {
        self.product = product
    }
}

struct ProductCellElement_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellElement(ProductModel(name: "Guitar", description: "test test teste testetstetstetstetstetstest", price: "231", article: "GB212412", type: "", quantity: "1", photos: []))
    }
}
