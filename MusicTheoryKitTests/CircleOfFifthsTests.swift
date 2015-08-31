//
//  CircleOfFifthsTests.swift
//  MusicTheoryKit
//
//  Created by Thomas Hoddes on 2015-08-30.
//  Copyright © 2015 Thomas Hoddes. All rights reserved.
//

import MusicTheoryKit
import XCTest

class CircleOfFifthsTests: XCTestCase {
    
    func testMajorRootsAreInOrder() {
        let roots = CircleOfFifths(mode: .Major).roots
        XCTAssertEqual(roots,[.C,.G,.D,.A,.E,.B,.GFlat,.DFlat,.AFlat,.EFlat,.BFlat,.F])
    }
    
    func testMinorRootsAreInOrder() {
        let roots = CircleOfFifths(mode: .Minor).roots
        XCTAssertEqual(roots,[.A,.E,.B,.FSharp,.CSharp,.GSharp,.EFlat,.BFlat,.F,.C,.G,.D])
    }
    
}
