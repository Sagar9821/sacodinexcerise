//
//  InspectionQuestionsDetailsView.swift
//  sacodinexcerise
//
//  Created by psagc on 23/07/24.
//

import SwiftUI
import UIKit

struct InspectionQuestionsDetailsView: View {
    
    @StateObject private var viewModel: InspectioQuestionDetailsViewModel
    
    init(viewModel: InspectioQuestionDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    var body: some View {
        content
    }
    
    private var content: some View {
        VStack{
            switch viewModel.inspection {
            case .notRequested:
                notRequestedView
            case .isLoading:
                loadingView
            case .loaded(let t):
                inspectionLoadedView(inspection: t)
            case .failed(let error):
                failedView(error)
            }
        }
    }
    
    var loadingView: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            
            ActivityIndicator()
                .foregroundColor(Color.gray)
                .frame(width: 20,height: 20)
        }
        
    }
    
    func inspectionLoadedView(inspection: InspectionResponse) -> some View{
        VStack {
            HStack {
                VStack {
                    Text("Area: " + inspection.inspection.area.name).frame(maxWidth: .infinity,alignment: .center)
                        .font(.headline)
                    Text("Inspection Type: " + inspection.inspection.inspectionType.name).frame(maxWidth: .infinity,alignment: .center)
                        .font(Font.system(size: 15,weight: .light))
                }
                Button(action: {
                    viewModel.moveToInspections()
                }, label: {
                    Image(systemName: "xmark")
                })
            }.padding([.leading,.trailing],20)
            List {
                ForEach(inspection.inspection.survey.categories,id: \.self) { data in
                    Section {
                        
                        InspectionQuestionsDetailsRowView(inspectionDetailsViewModel: viewModel, catagory: data)
                    } header: {
                        Text(data.name)
                            .foregroundStyle(Color.blue)
                            .font(.headline)
                    }
                }
            }
            Button("Submit") {
                viewModel.submitAnswer()
            }.buttonStyle(.bordered)
        }
        
    }
    
    var notRequestedView: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            
            Text("").onAppear {
                self.loadInspection()
            }
        }
    }
}
extension InspectionQuestionsDetailsView {
    func loadInspection() {
        viewModel.loadInspection()
    }
    

    
    func failedView(_ error: Error) -> some View {
        Text(error.localizedDescription)
    }
}





/*
#Preview {
    InspectionQuestionsDetailsView(viewModel: InspectioQuestionDetailsViewModel(inspectionService: InspectionService(webservice: WebService()), inspectionNavigator: InspectionNavigator(rootNavigator: Navigator(navigationController: UINavigationController())), inspection: InspectionResponse(inspection: Inspection(area: Area(id: 1, name: "Emergency ICU"), id: 4, inspectionType: InspectionType(access: "write", id: 1, name: "Clinical"), survey: Survey(categories: [Category(id: 1, name: "Drugs", questions: [Question(answerChoices: [AnswerChoice(id: 1, name: "Yes", score: 0.3),AnswerChoice(id: 2, name: "No", score: 0.3), AnswerChoice(id: 1, name: "NA", score: 0.3)], id: 1, name: "Is the drugs trolley locked?", selectedAnswerChoiceID: nil),Question(answerChoices: [AnswerChoice(id: 1, name: "Yes", score: 0.3),AnswerChoice(id: 2, name: "No", score: 0.3), AnswerChoice(id: 1, name: "NA", score: 0.3)], id: 2, name: "How many staff members are present in the ward?", selectedAnswerChoiceID: nil)])], id: 1)))))
}
*/



