//  Constants&Vars.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright © 2019 Deliveries. All rights reserved.
//

import UIKit

enum MYAPP {
    
    static let basicAuth = "*****"
    
    enum Api {
        enum Delivery {
            static let List = "\(Routes.main)/\(Routes.delivery)"
        }
    }
    
    enum Routes{
        static let main = "https://mock-api-mobile.dev.lalamove.com"
        static let delivery = "deliveries"
    }

}
