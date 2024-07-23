//
//  InspectionQuestionsDetailsRowView.swift
//  sacodinexcerise
//
//  Created by psagc on 23/07/24.
//

import SwiftUI

struct InspectionQuestionsDetailsRowView: View {
    var inspectionDetailsViewModel: InspectioQuestionDetailsViewModel
    var catagory: Category
    var body: some View {
        VStack {
            VStack {
                VStack(spacing: 10){
                    ForEach(catagory.questions,id: \.id) { question in
                        InspectionQuestionRowView(inspectionDetailsViewModel: inspectionDetailsViewModel, question: question)
                    }
                }
            }            
        }
    }
}
