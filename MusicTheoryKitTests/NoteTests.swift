//
//  NoteTests.swift
//  MusicKit
//
//  Created by Thomas Hoddes on 2014-06-06.
//  Copyright (c) 2014 Thomas Hoddes. All rights reserved.
//

import XCTest
import MusicTheoryKit

class NoteTests: XCTestCase {

    func testInitFromNameAndOctave() {
        let note = Note(.C, octave: 0)
        XCTAssert(note.equalTemperamentIndex == 0);
    }

    func testFrequencyOfZeroC() {
        let note = Note(.C, octave: 0)
        XCTAssert(note.frequency() == Note.ZeroCFrequency)
    }
    
    func testFrequencyOfA4() {
        let note = Note(.A, octave: 4)
        XCTAssertEqualWithAccuracy(note.frequency(), 440.0, accuracy: 0.02)
    }
    
    func testGetNoteNameC1() {
        let note = Note(.C, 1)
        XCTAssertEqual(note.name, Note.Name.C)
    }
    
    func testGetNoteNameF3() {
        let note = Note(.F, 3)
        XCTAssertEqual(note.name, Note.Name.F)
    }
    
    func testGetNoteNameB3() {
        let note = Note(.B, 3)
        XCTAssertEqual(note.name, Note.Name.B)
    }
    
}
