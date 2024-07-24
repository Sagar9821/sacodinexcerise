//
//  DraftedInspectionCell.swift
//  sacodinexcerise
//
//  Created by psagc on 24/07/24.
//

import UIKit

class DraftedInspectionCell: UITableViewCell {

    @IBOutlet private var inspectionIDNameLabel: UILabel?
    @IBOutlet private var inspectionTypeNameLabel: UILabel?
    @IBOutlet private var inspectionAreaLabel: UILabel?
    @IBOutlet private var inspectionQuestionAnsweredLabel: UILabel?
    
    var inspectionCompletedDetails: StoreInspection? {
        didSet {
            guard let id = inspectionCompletedDetails?.id ,
                    let questionAnswerd = inspectionCompletedDetails?.questionAnswered,
                  let numberOfQuestions = inspectionCompletedDetails?.numberOfQuestions else { return  }
            
            self.inspectionIDNameLabel?.text = "Inspection ID: #\(id)"
            self.inspectionTypeNameLabel?.text = inspectionCompletedDetails?.type
            self.inspectionAreaLabel?.text = inspectionCompletedDetails?.area
            self.inspectionQuestionAnsweredLabel?.text = "\(questionAnswerd)/\(numberOfQuestions) Question (0% left)"
        }
    }
}
