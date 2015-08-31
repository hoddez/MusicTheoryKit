//
//  Interval.swift
//  MusicKit
//
//  Created by Thomas Hoddes on 2014-06-08.
//  Copyright (c) 2014 Thomas Hoddes. All rights reserved.
//
public struct Interval: Hashable, Comparable, ForwardIndexType, CustomStringConvertible {
    public let size: Int
    public init(size: Int) {
        self.size = size
    }
    
    public static let PerfectUnison = Interval(size: 0)
    public static let MinorSecond = Interval(size: 1)
    public static let MajorSecond = Interval(size: 2)
    public static let MinorThird = Interval(size: 3)
    public static let MajorThird = Interval(size: 4)
    public static let PerfectFourth = Interval(size: 5)
    public static let Tritone = Interval(size: 6)
    public static let PerfectFifth = Interval(size: 7)
    public static let MinorSixth = Interval(size: 8)
    public static let MajorSixth = Interval(size: 9)
    public static let MinorSeventh = Interval(size: 10)
    public static let MajorSeventh = Interval(size: 11)
    public static let PerfectOctave = Interval(size: 12)
    public static let MinorNinth = Interval(size: 13)
    public static let MajorNinth = Interval(size: 14)
    public static let MinorTenth = Interval(size: 15)
    public static let MajorTenth = Interval(size: 16)
    public static let PerfectEleventh = Interval(size: 17)
    public static let DiminishedTwelfth = Interval(size: 18)
    public static let PerfectTwelfth = Interval(size: 19)
    public static let MinorThirteenth = Interval(size: 20)
    public static let MajorThirteenth = Interval(size: 21)
    public static let MinorFourteenth = Interval(size: 22)
    public static let MajorFourteenth = Interval(size: 23)
    public static let PerfectFifteenth = Interval(size: 24)
    public static let AugmentedFifteenth = Interval(size: 25)
    
    public static let DiminishedFifth = Interval.Tritone
    public static let AugmentedFourth = Interval.Tritone
}

//Helpers 
public extension Interval {
    public static func fromLowerNoteName(lowerNoteName: Note.Name, closestHigherNoteName: Note.Name) -> Interval {
        let stepsAbove = (closestHigherNoteName.stepsFromC + 12 - lowerNoteName.stepsFromC) % 12
        return Interval(size:  stepsAbove)
    }
}

//Printable
public extension Interval {
    public var description: String {
        let descriptions = [
            "Perfect Unison",
            "Minor Second",
            "Major Second",
            "Minor Third",
            "Major Third",
            "Perfect Fourth",
            "Tritone",
            "Perfect Fifth",
            "Minor Sixth",
            "Major Sixth",
            "Minor Seventh",
            "Major Seventh",
            "Perfect Octave",
            "Minor Ninth",
            "MajorNinth",
            "MinorTenth",
            "MajorTenth",
            "PerfectEleventh",
            "DiminishedTwelfth",
            "PerfectTwelfth",
            "MinorThirteenth",
            "MajorThirteenth",
            "MinorFourteenth",
            "MajorFourteenth",
            "PerfectFifteenth",
            "AugmentedFifteenth"
        ]
        return descriptions[self.size]
    }
    
    public var shortDescription: String {
        let shortDescriptions = [
            "P0",
            "m2",
            "M2",
            "m3",
            "M3",
            "P4",
            "TT",
            "P5",
            "m6",
            "M6",
            "m7",
            "M7",
            "P8",
            "m9",
            "M9",
            "m10",
            "M10",
            "P11",
            "d12",
            "P12",
            "m13",
            "M13",
            "m14",
            "M14",
            "P15",
            "A15"
        ]
        return shortDescriptions[self.size]
    }
}

//ForwardIndexType Conformance
public extension Interval {
    func successor() -> Interval {
        return Interval(size: self.size + 1)
    }
}

//Hashable
public extension Interval {
    var hashValue: Int {
        return size.hashValue
    }
}

//Comparable Conformance
public func == (left: Interval, right: Interval) -> Bool {
    return left.size == right.size
}

public func <= (left: Interval, right: Interval) -> Bool {
    return left.size <= right.size
}

public func >= (left: Interval, right: Interval) -> Bool {
    return left.size >= right.size
}

public func < (left: Interval, right: Interval) -> Bool {
    return left.size < right.size
}

//SubTypes
public extension Interval {
    public enum Phrasing {
        case Melodic(Set<Direction>)
        case Harmonic
        
        public var description: String {
            switch self {
            case .Melodic(let directions):
                let directionsDescriptions = directions.map({$0.description}).joinWithSeparator(" and ")
                return "Melodic \(directionsDescriptions)"
            case .Harmonic:
                return "Harmonic"
            }
        }
    }
}