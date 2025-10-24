//
//  GameManager.swift
//  FxiaSpot - GameLogic
//
//  Main game logic manager
//

import Foundation

/// Game manager delegate
protocol GameManagerDelegate: AnyObject {
    func gameManager(_ manager: GameManager, didUpdateScore score: Int)
    func gameManager(_ manager: GameManager, didUpdateCombo combo: Int)
    func gameManager(_ manager: GameManager, didCompleteRound earnedPoints: Int)
    func gameManager(_ manager: GameManager, didEndGame finalScore: Int)
}

/// Main game manager
final class GameManager {
    // MARK: - Properties
    private let strategy: DifficultyStrategy
    private let tileGenerator: TileGenerator

    private(set) var currentRound: TileGenerationResult?
    private(set) var gameState: GameState = .idle

    private var score: Int = 0 {
        didSet {
            delegate?.gameManager(self, didUpdateScore: score)
        }
    }

    private var combo: Int = 0 {
        didSet {
            delegate?.gameManager(self, didUpdateCombo: combo)
        }
    }

    private var roundCount: Int = 0
    private var session: GameSession?

    weak var delegate: GameManagerDelegate?

    // MARK: - Initialization
    init(strategy: DifficultyStrategy) {
        self.strategy = strategy
        self.tileGenerator = TileGenerator(strategy: strategy)
    }

    // MARK: - Game Flow
    func startGame() {
        score = 0
        combo = 0
        roundCount = 0
        session = GameSession(mode: strategy.modeId, startTime: Date())
        gameState = .playing(score: 0, combo: 0, round: 0)
        startNewRound()
    }

    func startNewRound() {
        guard gameState.isPlaying else { return }

        currentRound = tileGenerator.generateTiles()
        roundCount += 1
        gameState = .playing(score: score, combo: combo, round: roundCount)
    }

    /// Validate tile tap
    func validateTileTap(tileId: String) -> Bool {
        guard let round = currentRound else { return false }
        return round.minorityTiles.contains(tileId)
    }

    /// Process correct tap
    func processCorrectTap(tileId: String) {
        guard var round = currentRound else { return }

        // Remove from minority set
        var minoritySet = round.minorityTiles
        minoritySet.remove(tileId)
        currentRound = TileGenerationResult(
            tiles: round.tiles,
            minorityTiles: minoritySet,
            majorityType: round.majorityType
        )

        // Check if round completed
        if minoritySet.isEmpty {
            completeRound(success: true)
        }
    }

    /// Process wrong tap - game over
    func processWrongTap() {
        completeRound(success: false)
    }

    /// Complete current round
    private func completeRound(success: Bool) {
        if success {
            combo += 1
            let earnedPoints = strategy.calculateScore(combo: combo)
            score += earnedPoints

            delegate?.gameManager(self, didCompleteRound: earnedPoints)
            gameState = .playing(score: score, combo: combo, round: roundCount)
        } else {
            endGame()
        }
    }

    /// End game
    private func endGame() {
        let finalScore = score

        // Complete session
        session?.complete(score: finalScore, rounds: roundCount)

        // Reset state
        score = 0
        combo = 0
        roundCount = 0
        gameState = .gameOver(finalScore: finalScore)

        delegate?.gameManager(self, didEndGame: finalScore)
    }

    // MARK: - Getters
    func getCurrentScore() -> Int {
        return score
    }

    func getCurrentCombo() -> Int {
        return combo
    }

    func getRoundCount() -> Int {
        return roundCount
    }

    func isRoundComplete() -> Bool {
        return currentRound?.minorityTiles.isEmpty ?? false
    }

    func getRemainingTiles() -> Int {
        return currentRound?.minorityTiles.count ?? 0
    }

    func getGameSession() -> GameSession? {
        return session
    }
}
