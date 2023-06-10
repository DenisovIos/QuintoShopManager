//
//  TextFieldMod.swift
//  QuintoShopManager
//
//  Created by Руслан on 10.06.2023.
//

import Foundation
import SwiftUI

struct TextFieldMod: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(.white)
            .cornerRadius(5)
            .padding(.horizontal, 10)
    }
}
