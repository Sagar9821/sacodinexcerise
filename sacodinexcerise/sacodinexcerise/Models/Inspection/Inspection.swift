//
//  Inspection.swift
//  sacodinexcerise
//
//  Created by psagc on 21/07/24.
//

import Foundation

// MARK: - InspectionResponse
struct InspectionResponse: Codable {
    var inspection: Inspection
}

// MARK: - Inspection
struct Inspection: Codable {
    let area: Area
    let id: Int
    let inspectionType: InspectionType
    var survey: Survey
}

// MARK: - Area
struct Area: Codable {
    let id: Int
    let name: String
}

// MARK: - InspectionType
struct InspectionType: Codable {
    let access: String
    let id: Int
    let name: String
}

// MARK: - Survey
struct Survey: Codable, Hashable, Equatable {
    static func == (lhs: Survey, rhs: Survey) -> Bool {
        return lhs.id == rhs.id
    }
    
    var categories: [Category]
    let id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Category
struct Category: Codable, Hashable, Identifiable, Equatable {
    let id: Int
    let name: String
    var questions: [Question]
}

// MARK: - Question
struct Question: Codable, Identifiable, Hashable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.id == rhs.id
    }
    
    let answerChoices: [AnswerChoice]
    let id: Int
    let name: String
    var selectedAnswerChoiceID: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {
        case answerChoices, id, name
        case selectedAnswerChoiceID = "selectedAnswerChoiceId"
    }
}

// MARK: - AnswerChoice
struct AnswerChoice: Codable, Identifiable {
    let id: Int
    let name: String
    let score: Double
}
