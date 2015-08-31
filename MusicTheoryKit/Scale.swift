//
//  File.swift
//  MockingBird
//
//  Created by Thomas Hoddes on 2015-07-06.
//  Copyright (c) 2015 Thomas Hoddes. All rights reserved.
//

public struct Scale {
    public let root: Note.Name
    public let type: ScaleType
    public let preferredAccidental: Note.Accidental
    
    public init(_ root: Note.Name, _ type: ScaleType, preferredAccidental: Note.Accidental = .Sharp) {
        self.root = root
        self.type = type
        self.preferredAccidental = preferredAccidental
    }
    
    public func absoluteScale(octave: Int) -> AbsoluteScale {
        let rootNote = Note(root, octave)
        let rootNoteEqualTemperamentIndex = rootNote.equalTemperamentIndex
        let notes = type.steps.map { steps in
            return Note(equalTemperamentIndex: rootNoteEqualTemperamentIndex + steps, preferredAccidental: self.preferredAccidental)
        }
        return AbsoluteScale(notes)
    }
    
    public var noteNames: [Note.Name] {
        return absoluteScale(0).notes.map { $0.name }
    }
}

public struct AbsoluteScale {
    private let notes: [Note]
    public var root: Note { return notes.first! }
    
    init(_ notes: [Note]) {
        self.notes = notes
    }
    
    public func triadAtScaleDegree(scaleDegree: ScaleDegree) -> [Note] {
        let triadRoot = noteAtScalePosition(ScalePosition(scaleDegree,0))
        let triadThird = noteAtScalePosition(ScalePosition(scaleDegree,0).advancedBy(2))
        let triadFifth = noteAtScalePosition(ScalePosition(scaleDegree,0).advancedBy(4))
        return [triadRoot, triadThird, triadFifth]
    }
    
    public func noteAtScalePosition(scalePosition: ScalePosition) -> Note {
        let relativeNote = notes[scalePosition.degree.rawValue]
        let equalTemperamentIndex = relativeNote.equalTemperamentIndex + scalePosition.octave * 12
        return Note(equalTemperamentIndex: equalTemperamentIndex, preferredAccidental: relativeNote.name.accidental)
    }
}

public struct ScaleType : CustomStringConvertible, Hashable {
    public let steps: [Int]
    public let description: String
    
    public init(keyMode: Key.Mode) {
        self.steps = keyMode.steps
        self.description = keyMode.description
    }
    
    public init(steps: [Int], description: String) {
        self.steps = steps
        self.description = description
    }
    
    public var intervalsFromRoot: [Interval] {
        return (1..<steps.endIndex).map { index in
            return Interval(size: self.steps[index])
        }
    }
    
    public func intervalForScalePosition(scalePosition: ScalePosition) -> Interval {
        return Interval(size: self.steps[scalePosition.degree.rawValue] + 12 * scalePosition.octave)
    }
    
    public var melodicIntervals: [MelodicInterval] {
        return self.steps.map { MelodicInterval(steps: $0) }
    }
    
    public static let Ionian = Major
    public static let Dorian = ScaleType(keyMode: Key.Mode.Dorian)
    public static let Phrygian = ScaleType(keyMode: Key.Mode.Phrygian)
    public static let Lydian = ScaleType(keyMode: Key.Mode.Lydian)
    public static let Mixolydian = ScaleType(keyMode: Key.Mode.Mixolydian)
    public static let Aeolian = Minor
    public static let Locrian = ScaleType(keyMode: Key.Mode.Locrian)
    
    public static let Minor = ScaleType(keyMode: Key.Mode.Minor)
    public static let Major = ScaleType(keyMode: Key.Mode.Major)
    
}

public extension ScaleType {
    var hashValue: Int { return description.hashValue }
}

public func ==(left: ScaleType, right: ScaleType) -> Bool {
    return left.description == right.description && left.steps == right.steps
}

public struct ScalePosition : Comparable, ForwardIndexType, Hashable, CustomStringConvertible {
    let degree: ScaleDegree
    let octave: Int
    
    public init(_ degree: ScaleDegree, _ octave: Int) {
        self.degree = degree
        self.octave = octave
    }
    
    var position: Int { return degree.rawValue + octave * 7 }
        
    public func successor() -> ScalePosition {
        let newDegree = degree.next()
        return ScalePosition(newDegree, newDegree == .First ? octave + 1 : octave)
    }
    
    public var hashValue: Int {
        return position.hashValue
    }
    
    public var description: String {
        switch (degree, octave) {
        case let (degree, 0):
            return degree.description
        case (.First, 1):
            return "8th"
        default:
            return "\(degree.description) (+\(octave) Octave)"
        }
    }
}

public func <=(lhs: ScalePosition, rhs: ScalePosition) -> Bool {
    return lhs.position <= rhs.position
}

public func >=(lhs: ScalePosition, rhs: ScalePosition) -> Bool {
    return lhs.position >= rhs.position
}

public func >(lhs: ScalePosition, rhs: ScalePosition) -> Bool {
    return lhs.position > rhs.position
}

public func <(lhs: ScalePosition, rhs: ScalePosition) -> Bool {
    return lhs.position < rhs.position
}

public func ==(lhs: ScalePosition, rhs: ScalePosition) -> Bool {
    return lhs.degree == rhs.degree && lhs.octave == rhs.octave
}

public enum ScaleDegree : Int, CustomStringConvertible, Comparable, ForwardIndexType {
    case First
    case Second
    case Third
    case Fourth
    case Fifth
    case Sixth
    case Seventh
    
    public var description: String {
        switch self {
        case .First:
            return "Root"
        case .Second:
            return "2nd"
        case .Third:
            return "3rd"
        case .Fourth:
            return "4th"
        case .Fifth:
            return "5th"
        case .Sixth:
            return "6th"
        case .Seventh:
            return "7th"
        }
    }
    
    public func next() -> ScaleDegree {
        return ScaleDegree(rawValue: (rawValue + 1) % 7)!
    }
    
    public func successor() -> ScaleDegree {
        return next()
    }
}

public func <=(lhs: ScaleDegree, rhs: ScaleDegree) -> Bool {
    return lhs.rawValue <= rhs.rawValue
}

public func >=(lhs: ScaleDegree, rhs: ScaleDegree) -> Bool {
    return lhs.rawValue >= rhs.rawValue
}

public func >(lhs: ScaleDegree, rhs: ScaleDegree) -> Bool {
    return lhs.rawValue > rhs.rawValue
}

public func <(lhs: ScaleDegree, rhs: ScaleDegree) -> Bool {
    return lhs.rawValue < rhs.rawValue
}
