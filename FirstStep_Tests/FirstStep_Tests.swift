//
//  FirstStep_Tests.swift
//  FirstStep_Tests
//
//  Created by JaredMurray on 5/14/24.
//

import XCTest
@testable import FirstStep

/*Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
    test_Models_streakTime_doesSetCorrectStreak
 */
//Testing Structure: Given, When, Then

final class FirstStep_Tests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func test_Models_streakTime_doesSetCorrectStreak2() {
        //Given
        var overYearLongStreak: [Bool] = []
        let streak: DateComponents = .init()
        
        //When
        let loopCount: Int = Int.random(in: 1..<100)
        let seconds: Int = Int.random(in: 10000..<40000)
        for _ in 0..<loopCount {
            let result = streak.streakTime(habit: Date(timeIntervalSinceReferenceDate: TimeInterval(seconds)))
            if result.year! > 1 {
                overYearLongStreak.append(true)
            }
        }
        
        //Then
        XCTAssertEqual(overYearLongStreak.count, loopCount)
    }
}
