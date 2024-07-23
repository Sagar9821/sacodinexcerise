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
    @State private var selectedSegment = 0
    var body: some View {
        VStack(spacing: 20){
            Text(question.name)
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity,alignment: .leading)
            Picker("", selection: $selectedSegment) {
                ForEach(0..<question.answerChoices.count) { index in
                    Text(question.answerChoices[index].name)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedSegment) { newValue in
                let selectedAnswerID = String(question.answerChoices[newValue].id)
                inspectionDetailsViewModel.selectAnswer(for: question.id, answerChoiceID: selectedAnswerID)
            }
        }
        .padding(10)
        .background(Color(uiColor: AppColor.Backgrounds.lightGray))
        .cornerRadius(10)
    }
}

