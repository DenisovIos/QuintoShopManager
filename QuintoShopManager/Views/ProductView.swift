//
//  ProductView.swift
//  QuintoShopManager
//
//  Created by Руслан on 03.07.2023.
//

import SwiftUI
import PhotosUI

struct ProductView: View {
    @StateObject var viewModel = ProductViewModel()
    var product : ProductModel
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                ZStack(alignment: .center){
                    HStack {
                        Text(viewModel.product.name)
                            .font(.title)
                    }
                    HStack(){
                        Button {
                            viewModel.showEdit.toggle()
                        } label: {
                            Text(viewModel.showEdit ? "Отмена" : "Ред.")
                        }
                        Spacer()
                        if viewModel.showEdit {
                            Button {
                                print("удалить")
                            } label: {
                                Text( "Удалить")
                                    .tint(.red)
                            }
                        }
                    } .frame(maxWidth: .infinity)
                }.onAppear {
                    viewModel.product = product
                    Task{
                        await viewModel.changeAll()
                    }
                }
                .frame(maxWidth: .infinity)
                HStack{
                    Text("Название: ")
                        .frame(width: 100, alignment: .leading)
                    TextField("", text: $viewModel.name)
                        .modifier(TextFieldMod())
                        .disabled(!viewModel.showEdit)
                    
                    
                }
                VStack(alignment: .leading) {
                    Text("Описание: ")
                        .frame(width: 100, alignment: .leading)
                    TextField("", text: $viewModel.description, axis: .vertical)
                        .modifier(TextFieldMod())
                        .disabled(!viewModel.showEdit)
                }
                HStack{
                    Text("Цена: ")
                        .frame(width: 100, alignment: .leading)
                    
                    TextField("", text: $viewModel.price)
                        .modifier(TextFieldMod())
                        .disabled(!viewModel.showEdit)
                    
                }
                HStack{
                    Text("Кол-во: ")
                        .frame(width: 100, alignment: .leading)
                    
                    TextField("", text: $viewModel.quantity)
                        .modifier(TextFieldMod())
                        .disabled(!viewModel.showEdit)
                    
                }
                HStack{
                    Text("Артикул: ")
                        .frame(width: 100, alignment: .leading)
                    TextField("", text: $viewModel.article)
                        .modifier(TextFieldMod())
                        .disabled(!viewModel.showEdit)
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
                .disabled(!viewModel.showEdit)
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
                .disabled(!viewModel.showEdit)
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
                //TODO: отработка по булу
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
                                        .disabled(!viewModel.showEdit)
                                        .opacity(viewModel.showEdit ? 1 : 0)
                                        
                                    }
                                }
                            }
                        }.disabled(!viewModel.showEdit)
                        
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
                    !(viewModel.name.count > 2) || !(viewModel.article.count > 3) || !(viewModel.price.count > 2) || !(viewModel.quantity.count >= 1) || !viewModel.showEdit
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

extension ProductView {
    init (_ product : ProductModel) {
        self.product = product
    }
    
}


struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(ProductModel(name: "Guitar", description: "test test teste testetstetstetstetstetstest", price: "231", article: "GB212412", type: "", quantity: "1", photos: []))
    }
}
