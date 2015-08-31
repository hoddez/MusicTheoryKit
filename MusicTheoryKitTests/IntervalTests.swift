//
//  IntervalTests.swift
//  MusicKit
//
//  Created by Thomas Hoddes on 2014-09-18.
//  Copyright (c) 2014 Thomas Hoddes. All rights reserved.
//

import MusicTheoryKit
import XCTest

class IntervalTests: XCTestCase {

    func testIntervalFromNoteNames() {
        let interval = Interval.fromLowerNoteName(.C, closestHigherNoteName: .D)
        XCTAssertEqual(interval, Interval.MajorSecond)
    }
    
    func testIntervalFromNoteNamesLowerName() {
        let interval = Interval.fromLowerNoteName(.D, closestHigherNoteName: .C)
        XCTAssertEqual(interval, Interval.MinorSeventh)
    }
    
    func testIntervalFromNoteNamesSameName() {
        let interval = Interval.fromLowerNoteName(.C, closestHigherNoteName: .C)
        XCTAssertEqual(interval, Interval.PerfectUnison)
    }

}
