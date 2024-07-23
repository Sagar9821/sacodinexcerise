//
//  UpcomingInspectionCell.swift
//  sacodinexcerise
//
//  Created by psagc on 21/07/24.
//

import UIKit

class UpcomingInspectionCell: UITableViewCell {

    @IBOutlet private var inspectionNameLabel: UILabel?
    @IBOutlet private var inspectionTypeLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var inspectionDetails: Inspection? {
        didSet {
            inspectionNameLabel?.text = inspectionDetails?.area.name
            inspectionTypeLabel?.text = inspectionDetails?.inspectionType.name
        }
    }
    
}
