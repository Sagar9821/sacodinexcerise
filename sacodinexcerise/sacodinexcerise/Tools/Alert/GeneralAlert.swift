//
//  GeneralAlert.swift
//  sacodinexcerise
//
//  Created by psagc on 24/07/24.
//

import Foundation
import SwiftUI
import Combine

struct GeneralAlert: Equatable {
    static func == (lhs: GeneralAlert, rhs: GeneralAlert) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    struct AlertAction {
        var id: String = UUID().uuidString
        var title: String
        var action: (() -> ())?
    }
    var id: String = UUID().uuidString
    var title: String
    var message: String
    var action: [AlertAction]
}

struct GeneralAlerts: ViewModifier {
    
    @Binding var alertInfo:GeneralAlert?
    var isShowingAlert: Binding<Bool> {
        Binding {
            alertInfo != nil
        } set: { _ in
            alertInfo = nil
        }
    }
   
    
    func body(content: Content) -> some View {
        content
            .alert(alertInfo?.title ?? "Alert", isPresented: isShowingAlert, presenting: alertInfo) { details in
                alertActions(alert: details)
            } message: { details in
                Text(details.message)
            }
           
        
    }
    
    @ViewBuilder func alertActions(alert: GeneralAlert) -> some View {
        ForEach(alert.action,id: \.id) { action in
            Button(action.title) {
                action.action?()
            }
        }
    }
    
}

extension View {
    func alertInfo(_ alert: Binding<GeneralAlert?>) -> some View {
        self.modifier(GeneralAlerts(alertInfo: alert))
    }
}
