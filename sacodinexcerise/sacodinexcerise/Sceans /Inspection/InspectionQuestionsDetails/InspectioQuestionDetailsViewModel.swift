//
//  InspectioQuestionDetailsViewModel.swift
//  sacodinexcerise
//
//  Created by psagc on 23/07/24.
//

import Foundation
import Combine

enum InspectionDetailsType {
    case drafted(InspectionResponse)
    case new
}

enum ViewState {
    case loading
    case inspection
    case failed(error: String)
}

class InspectioQuestionDetailsViewModel: ObservableObject {
    
    var cancelBag: CancelBag = CancelBag()
    private let inspectionType: InspectionDetailsType
    private let inspectionService: InspectionServiceType
    private let inspectionNavigator: InspectionNavigator
    private let databaseServices: DatabaseServicesType
    
    @Published
    var inspection: Loadable<InspectionResponse> = .notRequested
    
    @Published
    var alert: GeneralAlert?
    
    init(inspectionType: InspectionDetailsType,
        inspectionService: InspectionServiceType,
         databaseServices: DatabaseServicesType,
         inspectionNavigator: InspectionNavigator) {
        self.inspectionType =  inspectionType
        self.inspectionService = inspectionService
        self.databaseServices = databaseServices
        self.inspectionNavigator = inspectionNavigator
        self.inspection = inspection
    }
    
    func loadInspection() {
        switch inspectionType {
        case .drafted(let inspection):
            self.inspection = .loaded(inspection)
        case .new:
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
    
    private func validateAllInspection(inspectionResponse: InspectionResponse) -> Bool{
        for categoryIndex in inspectionResponse.inspection.survey.categories.indices {
            for questionIndex in inspectionResponse.inspection.survey.categories[categoryIndex].questions.indices {
                if inspectionResponse.inspection.survey.categories[categoryIndex].questions[questionIndex].selectedAnswerChoiceID == nil {
                    print("Please fill all questions")
                    return false
                }
            }
        }
        return true
    }
    
    func submitAnswer() {
        switch inspection {
        case .loaded(let inspectionResponse):
            if validateAllInspection(inspectionResponse: inspectionResponse) {
                requestInspectionSubmit(inspection: inspectionResponse)
            } else {
                let actionSave = GeneralAlert.AlertAction(title: "Save") {
                    self.saveCompletedInspection(inspection: inspectionResponse)
                    self.inspectionNavigator.navigate(to: .inspection)
                }
                let actionCancel = GeneralAlert.AlertAction(title: "Cancel")
                
                self.alert = GeneralAlert(title: "Error", message: "You want to save this inspection and complete it later? .", action: [actionCancel,actionSave])
            }
            
        default:
            print("error")
        }
    }
    
    func requestInspectionSubmit(inspection: InspectionResponse) {
        inspectionService.submit(inspection: inspection).sink { [weak self] complition in
            if case let .failure(error) = complition{
                self?.alert = GeneralAlert(title: "Error", message: error.errorMessage ?? "", action: [GeneralAlert.AlertAction(title: "Ok")])
            }
        } receiveValue: { [weak self] _ in
            self?.databaseServices.deleteInspection(byID: inspection.inspection.id)
            let score = InspectionHelper.calculateScoreAndCompletionPercentage(from: inspection)
            let alertComplited = GeneralAlert(title: "Submitted", message: "Inspection submitted successfully final scroe for this inspection \(score.totalScore).", action: [GeneralAlert.AlertAction(title: "Ok",action: {
                self?.inspectionNavigator.navigate(to: .inspection)
            })])
            self?.alert = alertComplited
            self?.saveCompletedInspection(inspection: inspection)
        }.store(in: cancelBag)
    }
    
    func saveCompletedInspection(inspection: InspectionResponse) {
        databaseServices.saveInspection(inspection: inspection.inspection)
    }
}
