//
//  InspectioQuestionDetailsViewModel.swift
//  sacodinexcerise
//
//  Created by psagc on 23/07/24.
//

import Foundation
import Combine

enum ViewState {
    case loading
    case inspection
    case failed(error: String)
}

class InspectioQuestionDetailsViewModel: ObservableObject {
    
    var cancelBag: CancelBag = CancelBag()
    
    private let inspectionService: InspectionServiceType
    private let inspectionNavigator: InspectionNavigator
    
    @Published
    var inspection: Loadable<InspectionResponse> = .notRequested
    
    init(inspectionService: InspectionServiceType, inspectionNavigator: InspectionNavigator) {
        self.inspectionService = inspectionService
        self.inspectionNavigator = inspectionNavigator
        self.inspection = inspection
    }
    
    func loadInspection() {
        inspectionService.start().sink { [weak self] complition in
            switch complition {
            case .finished:
                print("Inspection Received")
            case .failure(let error):
                self?.inspection = .failed(error)
            }
        } receiveValue: { [weak self] inspectionData in
            guard let `self` = self else { return }
            self.inspection = .loaded(inspectionData)
        }.store(in: cancelBag)
    }
    
    func moveToInspections() {
        inspectionNavigator.navigate(to: .inspection)
    }
    
    func selectAnswer(for questionID: Int, answerChoiceID: String) {
        switch inspection {
        case .loaded(var inspectionResponse):
            for categoryIndex in inspectionResponse.inspection.survey.categories.indices {
                for questionIndex in inspectionResponse.inspection.survey.categories[categoryIndex].questions.indices {
                    if inspectionResponse.inspection.survey.categories[categoryIndex].questions[questionIndex].id == questionID {
                        inspectionResponse.inspection.survey.categories[categoryIndex].questions[questionIndex].selectedAnswerChoiceID = answerChoiceID
                        self.inspection = .loaded(inspectionResponse)
                        return
                    }
                }
            }
        default:
            break
        }
    }
    
    func submitAnswer() {
        switch inspection {
        case .loaded(let inspectionResponse):
            print(inspectionResponse)
        default:
            print("error")
        }
    }
}
