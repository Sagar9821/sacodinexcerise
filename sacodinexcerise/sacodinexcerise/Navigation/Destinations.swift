//
//  Destination.swift
//  sacodinexcerise
//
//  Created by psagc on 20/07/24.
//

import Foundation
enum AuthDetinations {
    case login
    case signUp
    case inspections
    case logout
}

enum Destinations {
    case login
    case signup
    case inspection
    case newInspection
    case draftedInspection(InspectionResponse)
    case logout
}
