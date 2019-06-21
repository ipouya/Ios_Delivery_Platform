//
//  Funcs.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/22/19.
//  Copyright © 2019 Pouyaghasemi. All rights reserved.
//

import UIKit

func getHeader() -> [String: String] {
    var appHeaders = ["Device-Id": UIDevice.current.identifierForVendor?.uuidString ?? "***"]
    
    if let otpToken = UserDefaults.standard.string(forKey: "Deliveries_AccessToken") {
        appHeaders.updateValue("Bearer " + otpToken, forKey: "Authorization")
    }
    return appHeaders
}

