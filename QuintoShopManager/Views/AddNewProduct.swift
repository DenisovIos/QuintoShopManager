//
//  AddNewProduct.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import SwiftUI
import PhotosUI

struct AddNewProduct: View {
    @StateObject var viewModel = AddNewProductViewModel()
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                HStack(){
                    Spacer()
                    Text("Новый товар")
                        .font(.title)
                    Spacer()
                }
                HStack{
                    Text("Название: ")
                        .frame(width: 100, alignment: .leading)
                    TextField("", text: $viewModel.name)
                        .modifier(TextFieldMod())
                    
                    
                }
                VStack(alignment: .leading) {
                    Text("Описание: ")
                        .frame(width: 100, alignment: .leading)
                    TextField("", text: $viewModel.description, axis: .vertical)
                        .modifier(TextFieldMod())
                }
                HStack{
                    Text("Цена: ")
                        .frame(width: 100, alignment: .leading)
                    
                    TextField("", text: $viewModel.price)
                        .modifier(TextFieldMod())
                    
                }
                HStack{
                    Text("Кол-во: ")
                        .frame(width: 100, alignment: .leading)
                    
                    TextField("", text: $viewModel.quantity)
                        .modifier(TextFieldMod())
                    
                }
                HStack{
                    Text("Артикул: ")
                        .frame(width: 100, alignment: .leading)
                    TextField("", text: $viewModel.article)
                        .modifier(TextFieldMod())
                }
                HStack {
                    Text("Категория :")
                        .frame(width: 100, alignment: .leading)
                        .frame(alignment: .leading)
                    Picker("Фильтр", selection: $viewModel.type) {
                        ForEach(viewModel.productTypeList) {
                            product in
                            Text(product.title)
                                .tag(product)
                        }
                        .pickerStyle(.inline)
                    }
                }
                PhotosPicker(selection: $viewModel.selectedItems, matching: .images) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                        HStack{
                            Text("Выбрать фото")
                                .foregroundColor(.white)
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                        }
                    }
                    .frame(height: 50)
                }
                .onChange(of: viewModel.selectedItems) { newValues in
                    Task {
                        viewModel.selectedImages = []
                        if viewModel.selectedItems.count > 0 {
                            for img in viewModel.selectedItems {
                                if let data = try await img.loadTransferable(type: Data.self ) {
                                    guard let image = UIImage(data: data) else {return}
                                    viewModel.selectedImages.append(image)
                                }
                                  
                            }
                        }
                    }
                }
                HStack{
                    if viewModel.selectedImages.count > 0 {
                        ScrollView(.horizontal){
                            HStack{
                                ForEach( $viewModel.selectedImages, id: \.self) { image in
                                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)){
                                        Image(uiImage: image.wrappedValue)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 150,height: 150)
                                            .clipped()
                                            .padding(20)
                                        Button {
                                            viewModel.removeImage(image.wrappedValue)
                                        } label: {
                                            ZStack{
                                                Circle()
                                                    .foregroundColor(.white)
                                                    .frame(width: 40, height: 40)
                                                Image(systemName: "trash")
                                                    .resizable()
                                                    .frame(width: 30,height: 30)
                                                    .foregroundColor(.red)
                                            }
                                        }

                                    }
                                }
                            }
                        }
                       
                    } else {
                        Image(systemName: "photo.artframe")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150,height: 150)
                            .clipped()
                            .padding(20)
                    }
                }
                
                Button {
                    Task {
                        let photos = try await StorageManager.shared.uploadImages(viewModel.selectedImages, viewModel.article)
                        try await FirestoreService.shared.addNewProduct(ProductModel(name: viewModel.name, description: viewModel.description, price: viewModel.price, article: viewModel.article, type: viewModel.type.title, quantity: viewModel.quantity, photos: photos), photos)
                        DispatchQueue.main.async {
                            viewModel.showOk.toggle()
                            viewModel.clearAll()
                        }
                    }
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                        HStack{
                            Text("Сохранить товар")
                                .foregroundColor(.white)
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                        }
                    }
                    .frame(height: 50)
                }
                .disabled(
                    !(viewModel.name.count > 2) || !(viewModel.article.count > 3) || !(viewModel.price.count > 2) || !(viewModel.quantity.count >= 1)
                )

                
            }
            .fullScreenCover(isPresented: $viewModel.showOk, content: {
                ProductAddedElement(checkIn: $viewModel.showOk)
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(10)
            .background(.gray.opacity(0.3))
            .blur(radius: viewModel.showOk ? 30 : 0)
            
    }
}

struct AddNewProduct_Previews: PreviewProvider {
    static var previews: some View {
        AddNewProduct()
    }
}
