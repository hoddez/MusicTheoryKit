//
//  MelodicIntervalTests.swift
//  MusicKit
//
//  Created by Thomas Hoddes on 2014-10-08.
//  Copyright (c) 2014 Thomas Hoddes. All rights reserved.
//

import MusicTheoryKit
import XCTest

class MelodicIntervalTests: XCTestCase {

    func testInitFromSteps() {
        let interval = MelodicInterval(steps: 2)
        XCTAssertEqual(interval.interval, Interval.MajorSecond)
        XCTAssertEqual(interval.direction, Direction.Ascending)
    }
    
    func testInitFromStepsDownward() {
        let interval = MelodicInterval(steps: -2)
        XCTAssertEqual(interval.interval, Interval.MajorSecond)
        XCTAssertEqual(interval.direction, Direction.Descending)
    }
    
    func testInitFromStepsUnison() {
        let interval = MelodicInterval(steps: 0)
        XCTAssertEqual(interval.interval, Interval.PerfectUnison)
        XCTAssertEqual(interval.direction, Direction.Flat)
    }
    
    func testAllMelodicIntervalsUpwards() {
        let directions: Set<Direction> = [.Ascending]
        let intervals: Set<Interval> = [.MajorSecond, .PerfectFourth]
        let allIntervals = MelodicInterval.allIntervals(intervals, directions: directions)
        
        XCTAssertTrue(allIntervals.contains(MelodicInterval(.MajorSecond,.Ascending)))
        XCTAssertTrue(allIntervals.contains(MelodicInterval(.PerfectFourth,.Ascending)))
        XCTAssertEqual(allIntervals.count, 2)
    }
    
    func testAllMelodicIntervalsFlat() {
        let directions: Set<Direction> = [.Ascending, .Flat]
        let intervals: Set<Interval> = [.MajorSecond, .PerfectFourth]
        let allIntervals = MelodicInterval.allIntervals(intervals, directions: directions)
        
        XCTAssertTrue(allIntervals.contains(MelodicInterval(.MajorSecond,.Ascending)))
        XCTAssertTrue(allIntervals.contains(MelodicInterval(.PerfectFourth,.Ascending)))
        XCTAssertTrue(allIntervals.contains(MelodicInterval(.PerfectUnison,.Flat)))
        XCTAssertEqual(allIntervals.count, 3)
    }
    
    func testAllMelodicIntervalsPerfectUnison() {
        let directions: Set<Direction> = [.Ascending]
        let intervals: Set<Interval> = [.MajorSecond, .PerfectFourth, .PerfectUnison]
        let allIntervals = MelodicInterval.allIntervals(intervals, directions: directions)
        
        XCTAssertTrue(allIntervals.contains(MelodicInterval(.MajorSecond,.Ascending)))
        XCTAssertTrue(allIntervals.contains(MelodicInterval(.PerfectFourth,.Ascending)))
        XCTAssertTrue(allIntervals.contains(MelodicInterval(.PerfectUnison,.Flat)))
        XCTAssertEqual(allIntervals.count, 3)
    }
    
    func testMelodicIntervalRangeFlatToMinorSecondUpwards() {
        let melodicIntervalRange = MelodicInterval(.PerfectUnison, .Flat)...MelodicInterval(.MinorSecond, .Ascending)
        XCTAssertEqual(melodicIntervalRange.map { $0 }, [MelodicInterval(.PerfectUnison, .Flat), MelodicInterval(.MinorSecond, .Ascending)])
    }
    
    func testMelodicIntervalHalfClosedRangeFlatToMinorSecondUpwards() {
        let melodicIntervalRange = MelodicInterval(.PerfectUnison, .Flat)..<MelodicInterval(.MinorSecond, .Ascending)
        XCTAssertEqual(melodicIntervalRange.map { $0 }, [MelodicInterval(.PerfectUnison, .Flat)])
    }
    
    func testMelodicIntervalRangeFlatToMajorSecondUpwards() {
        let melodicIntervalRange = MelodicInterval(.PerfectUnison, .Flat)...MelodicInterval(.MajorSecond, .Ascending)
        XCTAssertEqual(melodicIntervalRange.map { $0 }, [MelodicInterval(.PerfectUnison, .Flat),
            MelodicInterval(.MinorSecond, .Ascending),
            MelodicInterval(.MajorSecond, .Ascending)])
    }
    
    func testMelodicIntervalRangeMinorSecondDownwardstoMinorSecondUpwards() {
        let melodicIntervalRange = MelodicInterval(.MinorSecond, .Descending)...MelodicInterval(.MinorSecond, .Ascending)
        XCTAssertEqual(melodicIntervalRange.map { $0 }, [MelodicInterval(.MinorSecond, .Descending),
            MelodicInterval(.PerfectUnison, .Flat),
            MelodicInterval(.MinorSecond, .Ascending)])
    }
    
}
