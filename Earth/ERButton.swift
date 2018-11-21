//
//  ERButton.swift
//  Earth
//
//  Created by AlexanderKogut on 2/11/18.
//  Copyright © 2018 AlexanderKogut. All rights reserved.
//

import UIKit

class ERButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.addTarget(nil, action: #selector(ViewController.pressButton(sender:)), for: UIControlEvents.touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
