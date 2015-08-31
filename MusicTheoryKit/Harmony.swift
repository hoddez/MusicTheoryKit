//
//  Harmony.swift
//  MockingBird
//
//  Created by Thomas Hoddes on 2014-12-19.
//  Copyright (c) 2014 Thomas Hoddes. All rights reserved.
//

import Foundation

public struct Harmony : Equatable {
    private let noteCounts: [Note:Int]
    
    public var notes: [Note] {
        return noteCounts.reduce([Note]()) { (notes,dictItem) in
            return notes + Array<Note>(count: dictItem.1, repeatedValue: dictItem.0)
        }
    }
    
    public init(notes: [Note]) {
        var noteCounts = [Note:Int]()
        for note in notes {
            let noteCount = noteCounts[note] ?? 0
            noteCounts[note] = noteCount + 1
        }
        self.noteCounts = noteCounts
    }
}

public func ==(left: Harmony, right: Harmony) -> Bool {
    if left.noteCounts.count == right.noteCounts.count {
        let noteCountsAllEqual = true
        for (note, count) in left.noteCounts {
            if count != right.noteCounts[note] {
                return false
            }
        }
        return noteCountsAllEqual
    } else {
        return false
    }
}