//
//  ScoreDisplayView.swift
//  FxiaSpot - Views
//
//  Score and combo display view
//

import UIKit
import SnapKit

/// Score display view
final class ScoreDisplayView: UIView {
    // MARK: - UI Components
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score: 0"
        label.font = ThemeManager.shared.typography.titleFont(size: 26)
        label.textColor = ThemeManager.shared.goldColor
        label.textAlignment = .center

        // 添加发光效果
        label.layer.shadowColor = ThemeManager.shared.goldColor.cgColor
        label.layer.shadowRadius = 8
        label.layer.shadowOpacity = 0.6
        label.layer.shadowOffset = .zero

        return label
    }()

    private let comboLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = ThemeManager.shared.typography.buttonFont(size: 18)
        label.textColor = ThemeManager.shared.accentColor
        label.textAlignment = .center
        label.alpha = 0

        // 添加发光效果
        label.layer.shadowColor = ThemeManager.shared.accentColor.cgColor
        label.layer.shadowRadius = 10
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = .zero

        return label
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    // MARK: - Setup
    private func setupView() {
        addSubview(scoreLabel)
        addSubview(comboLabel)

        scoreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        comboLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    // MARK: - Public Methods
    func updateScore(_ score: Int) {
        scoreLabel.text = "Score: \(score)"
        // 添加弹跳动画
        scoreLabel.bounceAnimation(scale: 1.15)
    }

    func updateCombo(_ combo: Int) {
        if combo >= 3 {
            comboLabel.text = "🔥 Combo x\(combo)"
            UIView.animate(withDuration: 0.3) {
                self.comboLabel.alpha = 1
            }
            // 添加弹出动画
            comboLabel.popAnimation(scale: 1.2)
        } else {
            UIView.animate(withDuration: 0.3) {
                self.comboLabel.alpha = 0
            }
        }
    }

    func reset() {
        updateScore(0)
        updateCombo(0)
    }
}
