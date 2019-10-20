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
        
        setState(to: lane.locked)
        setUnitSystem(of: lane)
        setType(of: lane)
    }
    
    func setState(to locked: Bool) {
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 16,
                                                              weight: .light)
        if locked {
             laneLockedImageView.image = UIImage(systemName: "lock.fill", withConfiguration: symbolConfiguration)
             laneLockedImageView.tintColor = UIColor.systemRed
        } else {
            laneLockedImageView.image = UIImage(systemName: "lock.open.fill", withConfiguration: symbolConfiguration)
            laneLockedImageView.tintColor = UIColor.systemGreen
        }
    }
    
    func setUnitSystem(of lane: LaneModel) {
        guard let usi = lane.unitSystemIdentifier else {
            laneUnitSystemLabel.text = "NOT SET"
            return
        }
        if let unitSystem = UnitSystemIdentifier.getUnitSystemIdentifier(for: usi) {
            laneUnitSystemLabel.text = unitSystem.getCategory().description().uppercased()
        } else {
            laneUnitSystemLabel.text = "NOT SET".uppercased()
        }
    }
    
    func setType(of lane: LaneModel) {
        
        if lane.system {
            if lane.premium {
                laneTypeLabel.text = "PREMIUM"
                laneTypeLabel.textColor = .systemYellow
            } else {
                laneTypeLabel.text = "SYSTEM"
            }
        } else {
            laneTypeLabel.text = "CUSTOM"
        }
    }
}
