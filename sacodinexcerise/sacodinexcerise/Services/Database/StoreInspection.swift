//
//  StoreInspection.swift
//  sacodinexcerise
//
//  Created by psagc on 24/07/24.
//

import Foundation
import CoreData


struct StoreInspection {
    var id: Int64
    var type: String
    var area: String
    var questionAnswered: Int64
    var numberOfQuestions: Int64
    var data: Data
    init(manageObject: NSManagedObject) {
        self.id = manageObject.value(forKey: "id") as? Int64 ?? 0
        self.type = manageObject.value(forKey: "type") as? String ?? ""
        self.area = manageObject.value(forKey: "area") as? String ?? ""
        self.numberOfQuestions = manageObject.value(forKey: "numberOfQuestions") as? Int64 ?? 0
        self.questionAnswered = manageObject.value(forKey: "questionAnswered") as? Int64 ?? 0
        self.data = manageObject.value(forKey: "data") as? Data ?? Data()
    }
}
