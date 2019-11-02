//
//  LaneNumericEntryTableViewCell.swift
//  ProjectME
//
//  Created by Robert Sandru on 11/2/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

class LaneNumericEntryTableViewCell: UITableViewCell {

    @IBOutlet weak var upperTimelineLineView: UIView!
    @IBOutlet weak var lowerTimelineLineView: UIView!
    @IBOutlet weak var timelineDotView: UIView!
    @IBOutlet weak var cellDataContainerView: UIView!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureTimelineDot()
        configureDataContainer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureTimelineDot() {
        timelineDotView.layer.borderWidth = 1.6
        timelineDotView.layer.masksToBounds = true
        timelineDotView.layer.borderColor = UIColor.systemGreen.cgColor
        timelineDotView.layer.cornerRadius = 5
        timelineDotView.backgroundColor = .systemBackground
    }
    
    func configureDataContainer() {
        cellDataContainerView.cornerRadius = 15
    }
    
    func load(with entry: LaneEntryModel) {
        cellLabel.text = (entry.values?.allObjects as? [LaneEntryValueModel])?.first?.value
    }
    
    func load(with entry: LaneEntryModel, first: Bool) {
        upperTimelineLineView.isHidden = first
        lowerTimelineLineView.isHidden = !first
        load(with: entry)
    }
    
    func load(with entry: LaneEntryModel, last: Bool) {
        lowerTimelineLineView.isHidden = last
        upperTimelineLineView.isHidden = !last
        load(with: entry)
    }
    
    func load(with entry: LaneEntryModel, mid: Bool) {
        lowerTimelineLineView.isHidden = !mid
        upperTimelineLineView.isHidden = !mid
        load(with: entry)
    }
    
}
