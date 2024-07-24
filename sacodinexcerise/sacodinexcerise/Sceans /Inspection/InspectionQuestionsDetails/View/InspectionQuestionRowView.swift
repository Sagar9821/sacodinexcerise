//
//  InspectionQuestionRowView.swift
//  sacodinexcerise
//
//  Created by psagc on 23/07/24.
//

import SwiftUI

struct InspectionQuestionRowView: View {
    var inspectionDetailsViewModel: InspectioQuestionDetailsViewModel
    var question: Question
    @State private var selectedSegment: Int? = nil
    var body: some View {
        VStack(spacing: 20){
            Text(question.name)
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity,alignment: .leading)
            Picker("", selection: Binding(
                get: { selectedSegment ?? -1 },
                set: { newValue in
                    selectedSegment = newValue == -1 ? nil : newValue
                    if let index = selectedSegment {
                        let selectedAnswerID = String(question.answerChoices[index].id)
                        inspectionDetailsViewModel.selectAnswer(for: question.id, answerChoiceID: selectedAnswerID)
                    }
                }
            )) {
                ForEach(0..<question.answerChoices.count, id: \.self) { index in
                    Text(question.answerChoices[index].name)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding(10)
        .background(Color(uiColor: AppColor.Backgrounds.lightGray))
        .cornerRadius(10)
        .onAppear {
            // Initialize the selectedSegment based on the current selectedAnswerChoiceID
            if let selectedID = question.selectedAnswerChoiceID, let initialIndex = question.answerChoices.firstIndex(where: { String($0.id) == selectedID }) {
                selectedSegment = initialIndex
            }
        }
    }
}

