//
//  Chord.swift
//  MusicKit
//
//  Created by Thomas Hoddes on 2014-09-11.
//  Copyright (c) 2014 Thomas Hoddes. All rights reserved.
//

public struct Chord : Equatable, CustomStringConvertible, Hashable {
    public let root: Note.Name
    public let type: ChordType
    
    public init(triadWithRoot root:Note.Name, type: ChordType) {
        self.type = type
        self.root = root
    }

    public init(_ root:Note.Name, _ type: ChordType) {
        self.init(triadWithRoot: root, type: type)
    }
}

public extension Chord {
    public var description: String { return "\(root) \(type)"}
    public var shortDescription: String { return "\(root) \(type.shortDescription)"}
    
    public init?(root:Note.Name, third:Note.Name, fifth:Note.Name) {
        let thirdInterval = Interval.fromLowerNoteName(root, closestHigherNoteName: third)
        let fifthInterval = Interval.fromLowerNoteName(root, closestHigherNoteName: fifth)
        
        //TODO: iterate through all enum chord types and check getNoteNames?
        switch (thirdInterval, fifthInterval) {
        case (Interval.MajorThird, Interval.PerfectFifth):
            self.init(root, .Major)
        case (Interval.MinorThird, Interval.PerfectFifth):
            self.init(root, .Minor)
        case (Interval.MinorThird, Interval.Tritone):
            self.init(root, .Diminished)
        default:
            return nil
        }
    }
}

//Equatable
public func == (left: Chord, right: Chord) -> Bool {
    return left.type == right.type && left.root == right.root
}

//Hashable
public extension Chord {
    public var hashValue: Int {
        return description.hashValue
    }
}

// SubTypes
public extension Chord {
    public enum Inversion : Int {
        case RootPosition = 0
        case FirstInversion = 1
        case SecondInversion = 2
    }
    
    public enum ChordType : String, CustomStringConvertible {
        case Major = "Major"
        case Minor = "Minor"
        case Diminished = "Diminished"
        
        public var description: String { return rawValue }
        public var shortDescription: String {
            switch self {
            case .Major:
                return "Maj"
            case .Minor:
                return "Min"
            case .Diminished:
                return "Dim"
            }
        }
    }
    
    public enum HarmonicFunction {
        case Tonic
        case SubDominant
        case Dominant
        
        public static let allValues = [Tonic, SubDominant, Dominant]
    }
}