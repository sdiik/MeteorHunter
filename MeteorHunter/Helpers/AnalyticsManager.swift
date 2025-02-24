//
//  AnalyticsManager.swift
//  MeteorHunter
//
//  Created by ahmad shiddiq on 22/02/25.
//

import UIKit
import Foundation

class AnalyticsManager: NSObject{

    static let sharedInstance = AnalyticsManager()

    override init() {
        super.init()
    }
}

extension AnalyticsManager {
    
    func trackScene(_ name: String) {
    }
    
}
