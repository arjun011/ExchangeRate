//
//  ExchangeRateTests.swift
//  ExchangeRateTests
//
//  Created by Arjun on 21/04/22.
//

import XCTest
@testable import ExchangeRate

class ExchangeRateTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUpdateFavouriteList() throws {
        
        let inputDict = ["RON":0.040826,
                         "AFN":0.776204,
                         "AED":0.111]
        let favouriteList:Set = [["ALL":0.040826], ["AED":0.776204]]
        
        let liveRateModel = LiveRateViewModel()
        
        let output = liveRateModel.updateFavouriteList(inputDict: inputDict, favouriteListSet: favouriteList)
        
        let updateFavouriteList = output.updatedFavouriteListSet
        let outputDict = output.updatedRatesDict
        
        XCTAssertEqual(updateFavouriteList, [["ALL":0.040826], ["AED":0.111]], "Favourite list should be updated base on input value")
    
        XCTAssertNil(outputDict["AED"],"Remove object which is added on favourite list")
        
    }

    func testRetriveValueFromDictionary() throws {
        
        let inputDict = ["RON":0.040826]
        
        let liveRateModel = LiveRateViewModel()
        
        let output = liveRateModel.getValueFromDictionary(input: inputDict)
        
        XCTAssertEqual(output.0, "RON", "0 index sould be key name")
        XCTAssertEqual(output.1, 0.040826, "1 index should be value of key")
       
    }
    
    func testClientManagerRequest() throws {
       
        XCTAssertThrowsError(try ClientManager.GET(""),"Exception throw invalid url")
        
    }
    
    func testRetriveLatestRateListAPI() async throws {
        
        // Set
        let client = LiveRatesClient()
        
        let expectation = XCTestExpectation(description: "response")
        do {
            let response = try await client.retriveLatestRatesSync(base: "USD")
            switch response {
            case let .success(rates):
            
            XCTAssertEqual(rates.success, true)
            XCTAssertEqual(rates.base, "USD")
            
            expectation.fulfill()
            
            default:
                debugPrint("Offline")
            }
        }catch {
            debugPrint("Error",error.localizedDescription)
        }
        
        wait(for: [expectation], timeout: 3)
    }
}
