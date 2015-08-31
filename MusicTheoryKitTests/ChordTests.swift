//
//  ChordTests.swift
//  MusicKit
//
//  Created by Thomas Hoddes on 2014-09-11.
//  Copyright (c) 2014 Thomas Hoddes. All rights reserved.
//

import MusicTheoryKit
import XCTest

class ChordTests: XCTestCase {
    
    func testMajorChordFromRootThirdFifth() {
        let triad = Chord(root: .C, third: .E, fifth: .G)!
        XCTAssertEqual(triad.type,Chord.ChordType.Major)
    }
    
    func testMinorChordFromRootThirdFifth() {
        let triad = Chord(root: .C, third: .DSharp, fifth: .G)!
        XCTAssertEqual(triad.type,Chord.ChordType.Minor)
    }
    
    func testDiminishedChordFromRootThirdFifth() {
        let triad = Chord(root: .C, third: .DSharp, fifth: .FSharp)!
        XCTAssertEqual(triad.type,Chord.ChordType.Diminished)
    }

}
