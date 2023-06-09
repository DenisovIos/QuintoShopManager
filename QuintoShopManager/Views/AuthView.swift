//
//  AuthView.swift
//  QuintoShopManager
//
//  Created by Руслан on 09.06.2023.
//

import SwiftUI

struct AuthView: View {
    @StateObject var viewModel = AuthViewModel()
    var body: some View {
        VStack{
            Text("Магазин Квинто")
                .font(.largeTitle)
            Text("менеджер заказов")
                .font(.title)
            Spacer()
            VStack(alignment: .center, spacing: 20){
                HStack{
                    TextField("Введите логин", text: $viewModel.login)
                        .padding(.horizontal, 20)
                        .frame(height: 45)
                        
                }
                .background(.white)
                .cornerRadius(10)
                HStack{
                    TextField("Введите пароль", text: $viewModel.password)
                        .padding(.horizontal, 20)
                        .frame(height: 45)
                        
                    
                }
                .background(.white)
                .cornerRadius(10)
                
                Button {
                    Task{
                        let result = try await AuthService.shared.signIn(login: viewModel.login, password: viewModel.password)
                        DispatchQueue.main.async {
                            viewModel.check = result
                        }
                        
                    }
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue)
                        Text("Войти")
                            .foregroundColor(.white)
                    }
                    .frame(width: 200, height: 50)
                }
                .fullScreenCover(isPresented: $viewModel.check) {
                    TabBarView()
                }
            }
            .padding(20)
            .background(.gray)
            .cornerRadius(30)
            .padding(20)
            
            Spacer()
            Button("Нужна помощь?") {
                viewModel.needHelp.toggle()
            }.sheet(isPresented: $viewModel.needHelp) {
                Text("Обратитесь к Владу Мади или Руслану Денисову")
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
