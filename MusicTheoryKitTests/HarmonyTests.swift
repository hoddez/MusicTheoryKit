//
//  HarmonyTests.swift
//  MockingBird
//
//  Created by Thomas Hoddes on 2015-01-21.
//  Copyright (c) 2015 Thomas Hoddes. All rights reserved.
//

import MusicTheoryKit
import XCTest

class HarmonyTests: XCTestCase {

    func testHarmonies_WithDifferentOrderAndSameNotes_AreEqual() {
        let harmony = Harmony(notes: [Note(.C,0),Note(.D,3)])
        let otherHarmony = Harmony(notes: [Note(.D,3),Note(.C,0)])
        XCTAssertEqual(harmony, otherHarmony)
    }
    
    func testHarmonies_WhereOneIsSubset_AreNotEqual() {
        let harmony = Harmony(notes: [Note(.C,0),Note(.D,3)])
        let otherHarmony = Harmony(notes: [Note(.C,0),Note(.D,3),Note(.E,3),])
        XCTAssertNotEqual(harmony, otherHarmony)
    }
    
    func testHarmonies_WithSameNotesAndDifferentCounts_AreNotEqual() {
        let harmony = Harmony(notes: [Note(.C,0),Note(.D,3)])
        let otherHarmony = Harmony(notes: [Note(.C,0),Note(.D,3),Note(.D,3),])
        XCTAssertNotEqual(harmony, otherHarmony)
    }

}
