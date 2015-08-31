//
//  Direction.swift
//  MusicTheoryKit
//
//  Created by Thomas Hoddes on 2015-08-16.
//  Copyright © 2015 Thomas Hoddes. All rights reserved.
//

public enum Direction : Int, CustomStringConvertible {
    case Flat = 0
    case Ascending = 1
    case Descending = -1
    
    public var description: String {
        switch self {
        case .Flat:
            return "Flat"
        case .Ascending:
            return "Ascending"
        case .Descending:
            return "Descending"
        }
    }
}