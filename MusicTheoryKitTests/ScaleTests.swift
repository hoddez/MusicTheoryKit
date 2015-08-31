//
//  ScaleTests.swift
//  MockingBird
//
//  Created by Thomas Hoddes on 2015-07-06.
//  Copyright (c) 2015 Thomas Hoddes. All rights reserved.
//

import MusicTheoryKit
import XCTest

class ScaleTests: XCTestCase {

    func testMajor() {
        let mode = ScaleType.Major
        XCTAssertEqual(mode.steps, [0,2,4,5,7,9,11])
    }
    
    func testMinor() {
        let mode = ScaleType.Minor
        XCTAssertEqual(mode.steps, [0,2,3,5,7,8,10])
    }
    
    func testIntervalsFromRoot_MajorMode() {
        let mode = ScaleType.Major
        let expectedIntervalsFromRoot: [Interval] = [.MajorSecond, .MajorThird,.PerfectFourth,.PerfectFifth, .MajorSixth, .MajorSeventh]
        XCTAssertEqual(mode.intervalsFromRoot, expectedIntervalsFromRoot)
    }
    
    func testMelodicIntervalsMinor() {
        let minorScale = ScaleType(keyMode: .Minor)
        let expectedIntervals = [Interval.MajorSecond,
            Interval.MinorThird,
            Interval.PerfectFourth,
            Interval.PerfectFifth,
            Interval.MinorSixth,
            Interval.MinorSeventh]
        let expectedMelodicIntervals = [MelodicInterval(.PerfectUnison, .Flat)] + expectedIntervals.map { MelodicInterval($0, .Ascending) }
        XCTAssertEqual(minorScale.melodicIntervals, expectedMelodicIntervals)
    }

}

class ScalePositionTests: XCTestCase {
    func testOverlappingRange() {
        let range = ScalePosition(.Sixth,0)...ScalePosition(.First,1)
        XCTAssertEqual(Array(range), [ScalePosition(.Sixth,0),ScalePosition(.Seventh,0),ScalePosition(.First,1)])
    }
}

class ScaleDegreeTests: XCTestCase {
    func testNext_ReturnsFirst_WhenGivenSeventh() {
        XCTAssertEqual(ScaleDegree.Seventh.next(), ScaleDegree.First)
    }
}
