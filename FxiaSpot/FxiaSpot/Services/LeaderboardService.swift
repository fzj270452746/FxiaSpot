//
//  LeaderboardService.swift
//  FxiaSpot - Services
//
//  Leaderboard service with repository pattern
//

import Foundation

/// Leaderboard repository protocol
protocol LeaderboardRepository {
    func save(entry: LeaderboardEntry)
    func fetchAll() -> [LeaderboardEntry]
    func fetchByMode(_ mode: String) -> [LeaderboardEntry]
    func deleteAll()
}

/// UserDefaults-based repository implementation
final class UserDefaultsLeaderboardRepository: LeaderboardRepository {
    private let userDefaults: UserDefaults
    private let storageKey = "LeaderboardEntries"
    private let maxEntries = 100

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func save(entry: LeaderboardEntry) {
        var entries = fetchAll()
        entries.append(entry)
        entries.sort() // Uses Comparable implementation

        // Keep only top entries
        if entries.count > maxEntries {
            entries = Array(entries.prefix(maxEntries))
        }

        saveEntries(entries)
    }

    func fetchAll() -> [LeaderboardEntry] {
        guard let data = userDefaults.data(forKey: storageKey),
              let entries = try? JSONDecoder().decode([LeaderboardEntry].self, from: data) else {
            return []
        }
        return entries
    }

    func fetchByMode(_ mode: String) -> [LeaderboardEntry] {
        return fetchAll().filter { $0.mode == mode }
    }

    func deleteAll() {
        userDefaults.removeObject(forKey: storageKey)
    }

    private func saveEntries(_ entries: [LeaderboardEntry]) {
        if let encoded = try? JSONEncoder().encode(entries) {
            userDefaults.set(encoded, forKey: storageKey)
        }
    }
}

/// Leaderboard service
final class LeaderboardService {
    static let shared = LeaderboardService()

    private let repository: LeaderboardRepository

    init(repository: LeaderboardRepository = UserDefaultsLeaderboardRepository()) {
        self.repository = repository
    }

    /// Save a new score
    func saveScore(_ score: Int, mode: String, duration: TimeInterval? = nil) {
        let entry = LeaderboardEntry(score: score, mode: mode, duration: duration)
        repository.save(entry: entry)
    }

    /// Get top scores for a specific mode
    func getTopScores(mode: String, limit: Int = 50) -> [LeaderboardEntry] {
        let entries = repository.fetchByMode(mode)
        return Array(entries.prefix(limit))
    }

    /// Get highest score for a mode
    func getHighScore(mode: String) -> Int {
        let entries = getTopScores(mode: mode, limit: 1)
        return entries.first?.score ?? 0
    }

    /// Get all scores
    func getAllScores() -> [LeaderboardEntry] {
        return repository.fetchAll()
    }

    /// Clear all scores
    func clearAllScores() {
        repository.deleteAll()
    }

    /// Get rank for a score in a specific mode
    func getRank(score: Int, mode: String) -> Int? {
        let entries = repository.fetchByMode(mode)
        guard let index = entries.firstIndex(where: { $0.score <= score }) else {
            return entries.isEmpty ? 1 : entries.count + 1
        }
        return index + 1
    }
}
