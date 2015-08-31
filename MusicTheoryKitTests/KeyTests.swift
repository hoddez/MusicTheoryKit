//
//  KeyTests.swift
//  MusicKit
//
//  Created by Thomas Hoddes on 2014-09-30.
//  Copyright (c) 2014 Thomas Hoddes. All rights reserved.
//

import MusicTheoryKit
import XCTest

class KeyTests: XCTestCase {

    func testChordsInKey() {
        let key = Key(.C,.Major)
        XCTAssertEqual(key.chords[0],Chord(.C,.Major))
        XCTAssertEqual(key.chords[1],Chord(.D,.Minor))
        XCTAssertEqual(key.chords[2],Chord(.E,.Minor))
        XCTAssertEqual(key.chords[3],Chord(.F,.Major))
        XCTAssertEqual(key.chords[4],Chord(.G,.Major))
        XCTAssertEqual(key.chords[5],Chord(.A,.Minor))
        XCTAssertEqual(key.chords[6],Chord(.B,.Diminished))
    }
    
    func testCMajorNoteNames() {
        let key = Key(.C, .Major)
        XCTAssertEqual(key.noteNames, [.C,.D,.E,.F,.G,.A,.B])
    }
    
    func testAMinorNoteNames() {
        let key = Key(.A, .Minor)
        XCTAssertEqual(key.noteNames, [.A,.B,.C,.D,.E,.F,.G])
    }
    
    func testGMajorNoteNames() {
        let key = Key(.G, .Major)
        XCTAssertEqual(key.noteNames, [.G,.A,.B,.C,.D,.E,.FSharp])
    }
    
    func testFMajorNoteNames() {
        let key = Key(.F, .Major)
        XCTAssertEqual(key.noteNames, [.F,.G,.A,.BFlat,.C,.D,.E])
    }
    
    func testDominantChordsInKey() {
        let key = Key(.C,.Major)
        XCTAssertEqual(key.dominantChords, [Chord(.G,.Major),Chord(.E,.Minor)])
    }
    
    func testSubDominantChordsInKey() {
        let key = Key(.C,.Major)
        XCTAssertEqual(key.subDominantChords, [Chord(.F,.Major),Chord(.D,.Minor)])
    }
    
    func testFilterNotesInKey() {
        let key = Key(.C,.Major)
        let notes: Set<Note> = [Note(.C,3), Note(.D,3), Note(.DSharp, 3), Note(.E,3), Note(.C,4)]
        XCTAssertEqual(key.filterNotes(notes), [Note(.C,3), Note(.D,3), Note(.E,3), Note(.C,4)])
    }

}
