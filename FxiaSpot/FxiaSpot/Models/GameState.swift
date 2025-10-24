//
//  GameState.swift
//  FxiaSpot - Models
//
//  Game state model with enum-based state machine
//

import Foundation

/// Game state enumeration
enum GameState {
    case idle
    case playing(score: Int, combo: Int, round: Int)
    case gameOver(finalScore: Int)

    var score: Int {
        switch self {
        case .idle: return 0
        case .playing(let score, _, _): return score
        case .gameOver(let finalScore): return finalScore
        }
    }

    var combo: Int {
        switch self {
        case .idle: return 0
        case .playing(_, let combo, _): return combo
        case .gameOver: return 0
        }
    }

    var round: Int {
        switch self {
        case .idle: return 0
        case .playing(_, _, let round): return round
        case .gameOver: return 0
        }
    }

    var isPlaying: Bool {
        if case .playing = self { return true }
        return false
    }

    var isGameOver: Bool {
        if case .gameOver = self { return true }
        return false
    }
}

/// Round result
enum RoundResult {
    case success(earnedPoints: Int)
    case failure
}

/// Game session model
struct GameSession {
    let mode: String
    let startTime: Date
    var endTime: Date?
    var finalScore: Int = 0
    var totalRounds: Int = 0

    var duration: TimeInterval? {
        guard let end = endTime else { return nil }
        return end.timeIntervalSince(startTime)
    }

    mutating func complete(score: Int, rounds: Int) {
        endTime = Date()
        finalScore = score
        totalRounds = rounds
    }
}
