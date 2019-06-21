//
//  DeliveriesTests.swift
//  DeliveriesTests
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright © 2019 Deliveries. All rights reserved.
//

import XCTest
@testable import Deliveries

class DeliveriesTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }


    func testServerApi() {
        let req = DeliveryList.FetchData.Request(limit: 10, offset: 0)
        DataService.GetDeliveries(req: req) { res in
            let response = DeliveryList.FetchData.Response(state: res)
            switch response.state {
            case .success(let obj):
                XCTAssertEqual(obj.count, 10)
            default :
                XCTFail()
            }
        }
    }

    func testPerformanceGetDataFromCache() {
        // performance test case.
        self.measure {
            _ = RealmService.GetDeliveries()
        }
    }

}
