//
//  Key.swift
//  MusicKit
//
//  Created by Thomas Hoddes on 2014-06-26.
//  Copyright (c) 2014 Thomas Hoddes. All rights reserved.
//

public struct Key : Hashable {
    public let root: Note.Name
    public let mode: Mode

    public init(_ root: Note.Name, _ mode: Mode) {
        self.root = root
        self.mode = mode
    }
}

public extension Key {

    public enum Mode : Int, CustomStringConvertible {
        case Major
        case Dorian
        case Phrygian
        case Lydian
        case Mixolydian
        case Minor
        case Locrian
        
        public var steps: [Int] {
            return diatonicSteps(rawValue)
        }
        
        public var scaleType: ScaleType {
            return ScaleType(keyMode: self)
        }
        
        public var description: String {
            switch self {
            case Major:
                return "Major"
            case Dorian:
                return "Dorian"
            case Phrygian:
                return "Phrygian"
            case Lydian:
                return "Lydian"
            case Mixolydian:
                return "Mixolydian"
            case Minor:
                return "Minor"
            case Locrian:
                return "Locrian"
            }
        }
        
        public func descriptionForChord(scaleDegree: ScaleDegree) -> String {
            switch (self, scaleDegree) {
            case (.Major, .First):
                return "I"
            case (.Major, .Second):
                return "ii"
            case (.Major, .Third):
                return "iii"
            case (.Major, .Fourth):
                return "IV"
            case (.Major, .Fifth):
                return "V"
            case (.Major, .Sixth):
                return "vi"
            case (.Major, .Seventh):
                return "vii°"
                
            case (.Minor, .First):
                return "i"
            case (.Minor, .Second):
                return "ii°"
            case (.Minor, .Third):
                return "III"
            case (.Minor, .Fourth):
                return "iv"
            case (.Minor, .Fifth):
                return "v"
            case (.Minor, .Sixth):
                return "VI"
            case (.Minor, .Seventh):
                return "VII"
            default:
                fatalError("Need to define these for all Modes")
            }
        }
    }
}

public extension Key {
    public var chords: [Chord] {
        var chords = [Chord]()
        for (rootIndex, root) in noteNames.enumerate() {
            let chord = Chord(root: root,
                third: noteNames[(rootIndex + 2) % noteNames.count] ,
                fifth: noteNames[(rootIndex + 4) % noteNames.count])!
            chords.append(chord)
        }
        return chords
    }
    
    public var dominantChords: [Chord] {
        //TODO: add Diminished possibly?
        return [chords[4],chords[2]]
    }
    
    public var subDominantChords: [Chord] {
        return [chords[3],chords[1]]
    }
    
    public var noteNames: [Note.Name] {
        return scale.noteNames
    }
    
    public var scale: Scale {
        return Scale(self.root, self.mode.scaleType, preferredAccidental: preferredAccidental)
    }
    
    private var preferredAccidental: Note.Accidental {
        let circle = CircleOfFifths(mode: mode)
        let position = circle.positionForStepsFromC(root.stepsFromC)
        return circle.preferredAccidentalForPosition(position)
    }
    
    public func getChords(harmonicFunction: Chord.HarmonicFunction) -> [Chord] {
        switch harmonicFunction {
        case .Tonic:
            return [chords[0]]
        case .SubDominant:
            return subDominantChords
        case .Dominant:
            return dominantChords
        }
    }
    
    public func getChords(mode: Chord.ChordType) -> [Chord] {
        return self.chords.filter { $0.type == mode }
    }
    
    public func getHarmonicFunction(chord: Chord) -> Chord.HarmonicFunction? {
        var harmonicFunctionMatch: Chord.HarmonicFunction?
        
        for harmonicFunction in Chord.HarmonicFunction.allValues {
            if getChords(harmonicFunction).contains(chord) {
                harmonicFunctionMatch = harmonicFunction
            }
        }
        
        return harmonicFunctionMatch
    }
    
    public func filterNotes(notes: Set<Note>) -> Set<Note> {
        return Set(notes.filter() { note in
            return self.noteNames.contains(note.name)
        })
    }
}

//Hashable
public extension Key {
    var hashValue: Int {
        return "\(root.hashValue) \(mode.hashValue)".hashValue
    }
}

public func ==(left: Key, right: Key) -> Bool {
    return left.hashValue == right.hashValue
}

public func diatonicSteps(rootIndex: Int) -> [Int] {
    let diatonicSteps = [0,2,4,5,7,9,11]
    let rootStep = diatonicSteps[rootIndex]
    return (0..<diatonicSteps.count).map { step in
        let stepIndex = (step + rootIndex) % diatonicSteps.count
        let stepsFromRoot = diatonicSteps[stepIndex] - rootStep
        return stepsFromRoot < 0 ? stepsFromRoot + 12 : stepsFromRoot
    }
}