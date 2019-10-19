//
//  TextFieldWithLabel.swift
//  ProjectME
//
//  Created by Robert Sandru on 10/19/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit

class TextFieldWithLabel: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var borderBottom: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeContentView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeContentView()
    }
    
    func customizeContentView() {
        Bundle.main.loadNibNamed("TextFieldWithLabel", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        
        contentView.backgroundColor = UIColor.secondarySystemBackground
        borderBottom.backgroundColor = UIColor.tertiarySystemBackground
    }
}
