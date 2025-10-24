//
//  LeaderboardEntry.swift
//  FxiaSpot - Models
//
//  Leaderboard entry model
//

import Foundation

/// Leaderboard entry model
struct LeaderboardEntry: Codable {
    let score: Int
    let mode: String
    let date: Date
    let duration: TimeInterval?

    init(score: Int, mode: String, date: Date = Date(), duration: TimeInterval? = nil) {
        self.score = score
        self.mode = mode
        self.date = date
        self.duration = duration
    }

    /// Formatted date string
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    /// Formatted duration string
    var formattedDuration: String? {
        guard let duration = duration else { return nil }
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension LeaderboardEntry: Equatable {
    static func == (lhs: LeaderboardEntry, rhs: LeaderboardEntry) -> Bool {
        return lhs.score == rhs.score &&
               lhs.mode == rhs.mode &&
               lhs.date == rhs.date
    }
}

extension LeaderboardEntry: Comparable {
    static func < (lhs: LeaderboardEntry, rhs: LeaderboardEntry) -> Bool {
        if lhs.score != rhs.score {
            return lhs.score > rhs.score // Higher score comes first
        }
        return lhs.date > rhs.date // More recent comes first
    }
}
