//
//  TextViewWithLabel.swift
//  TracksNLanes
//
//  Created by Robert Sandru on 10/27/19.
//  Copyright © 2019 codecontrive. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TextViewWithLabel: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var borderBottom: UIView!
    
    var pickerView: UIPickerView?
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeContentView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customizeContentView()
    }
    
    func customizeContentView() {
        Bundle.main.loadNibNamed("TextViewWithLabel", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        
        contentView.backgroundColor = UIColor.secondarySystemBackground
        borderBottom.backgroundColor = UIColor.tertiarySystemBackground
    }
}
