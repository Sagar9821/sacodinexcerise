//
//  AppButtonStyle.swift
//  sacodinexcerise
//
//  Created by psagc on 24/07/24.
//

import Foundation
import SwiftUI
struct AppButtonStyle: ButtonStyle {
    
    
    func makeBody(
        configuration: ButtonStyleConfiguration
    ) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(configuration.isPressed ? Color(uiColor: AppColor.Text.oceanBlue).opacity(0.5) : Color(uiColor: AppColor.Text.oceanBlue))
            .clipShape(RoundedRectangle(cornerRadius: 5,style: .continuous))
            
    }
}

#Preview {
    Button("Done") {
        
    }.buttonStyle(AppButtonStyle())
}

