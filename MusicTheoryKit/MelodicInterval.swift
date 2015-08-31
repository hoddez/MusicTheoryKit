//
//  MelodicInterval.swift
//  MusicKit
//
//  Created by Thomas Hoddes on 2014-10-07.
//  Copyright (c) 2014 Thomas Hoddes. All rights reserved.
//

public struct MelodicInterval : Equatable, ForwardIndexType, Hashable {
    public let steps: Int
    
    public init(steps: Int) {
        self.steps = steps
    }
    
    public init(_ interval: Interval, _ direction: Direction) {
        self.steps = interval.size * direction.rawValue
    }
}

public extension MelodicInterval {
    public var interval: Interval {
        return Interval(size:  abs(steps))
    }
    
    public var direction: Direction {
        switch self.steps {
        case let d where d > 0:
            return .Ascending
        case let d where d < 0:
            return .Descending
        default:
            return .Flat
        }
    }
    
    public static func allIntervals(intervals: Set<Interval>, directions: Set<Direction>) -> Set<MelodicInterval> {
        var allIntervals: Set<MelodicInterval> = []
        let intervalsExceptPerfectUnison = intervals.filter { return $0 != .PerfectUnison }
        let directionsExceptFlat = directions.filter { return $0 != .Flat }
        
        for direction in directionsExceptFlat {
            allIntervals.unionInPlace(intervalsExceptPerfectUnison.map { MelodicInterval($0, direction) })
        }
        
        if intervals.contains(Interval.PerfectUnison) || directions.contains(Direction.Flat) {
            allIntervals.insert(MelodicInterval(.PerfectUnison,.Flat))
        }
        
        return allIntervals
    }
    
    public var description: String {
        return "\(interval.description) \(direction.description)"
    }
}

//ForwardIndexType
public extension MelodicInterval {
    public func successor() -> MelodicInterval {
        return MelodicInterval(steps: steps + 1)
    }
}
//Equatable
public func == (left: MelodicInterval, right: MelodicInterval) -> Bool {
    return (left.interval == right.interval) && (left.direction == right.direction)
}

//Hashable
public extension MelodicInterval {
    var hashValue: Int { return steps }
}

public func < (left: MelodicInterval, right: MelodicInterval) -> Bool {
    return left.steps < right.steps
}

public func + (left: MelodicInterval, right: MelodicInterval) -> MelodicInterval {
    return MelodicInterval(steps: left.steps + right.steps)
}

public func - (left: MelodicInterval, right: MelodicInterval) -> MelodicInterval {
    return MelodicInterval(steps: left.steps - right.steps)
}