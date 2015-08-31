//
//  Note.swift
//  MusicKit
//
//  Created by Thomas Hoddes on 2014-06-05.
//  Copyright (c) 2014 Thomas Hoddes. All rights reserved.
//

public struct Note : Hashable, Comparable, CustomStringConvertible {

    public let name: Name
    public let octave: Int
    
    public init(_ name: Name, _ octave: Int) {
        precondition(octave >= 0, "Octave cannot be \(octave), must be >= 0")
        self.name = name
        self.octave = octave
    }
    
    public init(letter: Letter, accidental: Accidental, octave: Int) {
        self.init(Note.Name(letter, accidental),octave)
    }
    
    public init(_ letter: Letter, _ accidental: Accidental, _ octave: Int) {
        self.init(letter: letter, accidental: accidental, octave: octave)
    }
    
    public init(_ name: Name, octave: Int) {
        self.init(name, octave)
    }
    
    public init(equalTemperamentIndex: Int, preferredAccidental: Accidental) {
        self.octave = equalTemperamentIndex / 12
        let stepsFromC = equalTemperamentIndex % 12
        let accidentalPossibilties = Name.singleAccidentalPossibilities(stepsFromC)
        if let letter = accidentalPossibilties[.Natural] {
            self.name = Name(letter, .Natural)
        } else {
            let letter = accidentalPossibilties[preferredAccidental]!
            self.name = Name(letter, preferredAccidental)
        }
    }
}

//Helpers
public extension Note {
    public static let ZeroCFrequency = 16.352
    
    public func frequency(temperment: Temperament = .Equal) -> Double {
        switch temperment {
        case .Equal:
            return Note.ZeroCFrequency/pow(2, -1*Double(self.equalTemperamentIndex)/12.0)
        }
    }
    
    public var equalTemperamentIndex: Int { return name.stepsFromC + (octave * 12) }
}

//MIDI
public typealias MidiNote = UInt8
public extension Note {
    public var midiNumber: MidiNote  { return MidiNote(equalTemperamentIndex + 12) }
}

//Comparable
public func <= (left: Note, right: Note) -> Bool {
    return left.equalTemperamentIndex <= right.equalTemperamentIndex
}

public func >= (left: Note, right: Note) -> Bool {
    return left.equalTemperamentIndex >= right.equalTemperamentIndex
}

public func < (left: Note, right: Note) -> Bool {
    return left.equalTemperamentIndex < right.equalTemperamentIndex
}

public func == (left: Note, right: Note) -> Bool {
    return left.equalTemperamentIndex == right.equalTemperamentIndex
}

//Hashable
public extension Note {
    public var hashValue: Int { return equalTemperamentIndex }
}

//Printable
public extension Note {
    public var description: String {
        return name.description + octave.description
    }
}

//Note.Name
public extension Note {
    public struct Name : CustomStringConvertible, Hashable {
        public let letter: Letter
        public let accidental: Accidental
        
        public init(_ letter: Letter, _ accidental: Accidental = .Natural) {
            self.letter = letter
            self.accidental = accidental
        }
        
        public init(stepsFromC: Int, preferredAccidental: Accidental) {
            let possibilities = Name.singleAccidentalPossibilities(stepsFromC)
            if let letter = possibilities[.Natural] {
                self.init(letter, .Natural)
            } else {
                self.init(possibilities[preferredAccidental]!, preferredAccidental)
            }
        }
        
        private static func singleAccidentalPossibilities(stepsFromC: Int) -> [Accidental:Note.Letter] {
            switch stepsFromC {
            case 0:
                return [.Natural:.C]
            case 1:
                return [.Sharp:.C, .Flat:.D]
            case 2:
                return [.Natural:.D]
            case 3:
                return [.Sharp:.D, .Flat:.E]
            case 4:
                return [.Natural:.E]
            case 5:
                return [.Natural:.F]
            case 6:
                return [.Sharp:.F, .Flat: .G]
            case 7:
                return [.Natural:.G]
            case 8:
                return [.Sharp:.G, .Flat: .A]
            case 9:
                return [.Natural:.A]
            case 10:
                return [.Sharp:.A, .Flat: .B]
            case 11:
                return [.Natural:.B]
            default:
                fatalError("Steps From C Must be in [0,11]")
            }
        }
        
        public var stepsFromC: Int {
            return letter.stepsFromC + accidental.rawValue
        }
        
        public var description: String {
            return "\(letter.description)\(accidental.description)"
        }
        
        public var hashValue: Int {
            return "\(letter.hashValue)\(accidental.hashValue)".hashValue
        }
        
        public static let C: Name = Note.Name(.C)
        public static let CSharp: Name = Note.Name(.C, .Sharp)
        public static let DFlat: Name = Note.Name(.D, .Flat)
        public static let D: Name = Note.Name(.D)
        public static let DSharp: Name = Note.Name(.D, .Sharp)
        public static let EFlat: Name = Note.Name(.E, .Flat)
        public static let E: Name = Note.Name(.E)
        public static let F: Name = Note.Name(.F)
        public static let FSharp: Name = Note.Name(.F, .Sharp)
        public static let GFlat: Name = Note.Name(.G, .Flat)
        public static let G: Name = Note.Name(.G)
        public static let GSharp: Name = Note.Name(.G, .Sharp)
        public static let AFlat: Name = Note.Name(.A, .Flat)
        public static let A: Name = Note.Name(.A)
        public static let ASharp: Name = Note.Name(.A, .Sharp)
        public static let BFlat: Name = Note.Name(.B, .Flat)
        public static let B: Name = Note.Name(.B)
    }
    
    public enum Letter: Int, CustomStringConvertible {
        
        public var description: String {
            switch self {
            case .C:
                return "C"
            case .D:
                return "D"
            case .E:
                return "E"
            case .F:
                return "F"
            case .G:
                return "G"
            case .A:
                return "A"
            case .B:
                return "B"
            }
        }
        
        public var stepsFromC: Int {
            switch self {
            case .C:
                return 0
            case .D:
                return 2
            case .E:
                return 4
            case .F:
                return 5
            case .G:
                return 7
            case .A:
                return 9
            case .B:
                return 11
            }
        }
        
        case C, D, E, F, G, A, B
        public static let allValues = [C, D, E, F, G, A, B]
    }
    
    public enum Accidental : Int {
        case Sharp = 1
        case Flat = -1
        case Natural = 0
        
        var description: String {
            switch self {
            case .Natural:
                return "♮"
            case .Sharp:
                return "♯"
            case .Flat:
                return "♭"
            }
        }
    }
}

//Note.Name Equatable
public func ==(left: Note.Name, right: Note.Name) -> Bool {
    return left.letter == right.letter && left.accidental == right.accidental
}