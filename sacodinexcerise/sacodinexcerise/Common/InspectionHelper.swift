//
//  InspectionHelper.swift
//  sacodinexcerise
//
//  Created by psagc on 24/07/24.
//

import Foundation

struct InspectionHelper {
    static func calculateScoreAndCompletionPercentage(from inspectionResponse: InspectionResponse) -> (totalScore: Double, percentageCompleted: Double) {
        let survey = inspectionResponse.inspection.survey
        
        var totalScore: Double = 0
        var totalQuestions: Int = 0
        var answeredQuestions: Int = 0
        
        for category in survey.categories {
            for question in category.questions {
                totalQuestions += 1
                if let selectedAnswerId = question.selectedAnswerChoiceID {
                    if let selectedAnswer = question.answerChoices.first(where: { $0.id == Int(selectedAnswerId) }) {
                        totalScore += selectedAnswer.score
                        answeredQuestions += 1
                    }
                }
            }
        }
        
        let percentageCompleted = totalQuestions > 0 ? (Double(answeredQuestions) / Double(totalQuestions)) * 100 : 0
        
        return (totalScore, percentageCompleted)
    }

}
