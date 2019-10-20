//
//  LaneTableViewCell.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/20/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

class LaneTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var laneNameLabel: UILabel!
    @IBOutlet weak var laneDescriptionShortLabel: UILabel!
    @IBOutlet weak var laneDetailStackView: UIStackView!
    @IBOutlet weak var laneUnitSystemLabel: UILabel!
    @IBOutlet weak var laneLockedImageView: UIImageView!
    @IBOutlet weak var laneTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func load(lane: LaneModel) {
        
        cellBackgroundView.backgroundColor = .tertiarySystemGroupedBackground
        cellBackgroundView.layer.cornerRadius = 15
        
        laneNameLabel.text = lane.name ?? "Unnamed Lane"
        laneDescriptionShortLabel.text = lane.descriptionShort
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 16, weight: .light)
        laneLockedImageView.image = UIImage(systemName: "lock.open.fill", withConfiguration: symbolConfiguration)
        laneLockedImageView.tintColor = UIColor.systemGreen
        
        laneUnitSystemLabel.text = "Distance".uppercased()
        laneTypeLabel.text = "Custom".uppercased()
        
    }
}
