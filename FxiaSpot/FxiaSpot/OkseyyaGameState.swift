

import Foundation

class OkseyyaGameState {
    var dangqianCurrentScore: Int = 0
    var lianjsComboCount: Int = 0
    var zonhuiheTotalRounds: Int = 0
    var abshesMode: XdsiduGameMode

    init(leastFindMode: XdsiduGameMode) {
        self.abshesMode = leastFindMode
    }

    func choqisResetGame() {
        dangqianCurrentScore = 0
        lianjsComboCount = 0
        zonhuiheTotalRounds = 0
    }

    func suanjhsiaCalculateScore(isCorrect: Bool) -> Int {
        if isCorrect {
            lianjsComboCount += 1
            var scoreToAdd = abshesMode.leastFindBaseScore

            // Combo multiplier: starts at 3 combos
            if lianjsComboCount >= 3 {
                let multiplier = 1.0 + Double(lianjsComboCount - 2) * 0.2
                scoreToAdd = Int(Double(scoreToAdd) * multiplier)
            }

            dangqianCurrentScore += scoreToAdd
            zonhuiheTotalRounds += 1
            return scoreToAdd
        } else {
            lianjsComboCount = 0
            return 0
        }
    }
}
