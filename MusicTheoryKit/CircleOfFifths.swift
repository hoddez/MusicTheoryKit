//
//  CircleOfFifths.swift
//  MusicTheoryKit
//
//  Created by Thomas Hoddes on 2015-08-30.
//  Copyright © 2015 Thomas Hoddes. All rights reserved.
//

import Foundation

public struct CircleOfFifths {
    public let mode: Key.Mode
    
    public init(mode: Key.Mode) {
        self.mode = mode
    }
    
    public func rootAtPosition(position: Int) -> Note.Name {
        return Note.Name(stepsFromC: (topRoot.stepsFromC + position * 7) % 12, preferredAccidental: preferredAccidentalForPosition(position))
    }
    
    public func preferredAccidentalForPosition(position: Int) -> Note.Accidental {
        return position <= 5 ? .Sharp : .Flat
    }
    
    public var roots: [Note.Name] {
        return (0...11).map(rootAtPosition)
    }
    
    public func positionForStepsFromC(stepsFromC: Int) -> Int {
        for (position, name) in roots.enumerate() {
            if name.stepsFromC == stepsFromC {
                return position
            }
        }
        fatalError("No Position Found For Steps. This Shouldn't ever happen")
    }
    
    public var topRoot: Note.Name {
        let letter = Note.Letter(rawValue: Note.Letter.C.rawValue + mode.rawValue)!
        return Note.Name(letter, .Natural)
    }
}