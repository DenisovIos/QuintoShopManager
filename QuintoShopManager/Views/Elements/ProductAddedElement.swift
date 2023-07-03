//
//  ProductAddedElement.swift
//  QuintoShopManager
//
//  Created by Руслан on 03.07.2023.
//

import SwiftUI

struct ProductAddedElement: View {
    @Binding var checkIn: Bool
    var body: some View {
        VStack{
            VStack {
                Text("Товар добавлен")
                Button {
                    checkIn.toggle()
                } label: {
                    HStack {
                        Text("OK")
                            .tint(.white)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(5)
                }
                
                
            }
            .frame(width: 200, height: 150)
            .background(.white)
            .cornerRadius(5)
        }
        .background(.clear)
    }
}

