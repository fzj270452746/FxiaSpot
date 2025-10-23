//
//  LeastFindSettingsViewController.swift
//  FxiaSpot
//
//  Created by Claude on 2025-01-23.
//

import UIKit
import SnapKit

class LeastFindSettingsViewController: UIViewController {

    private let leastFindGradientLayer = LeastFindTheme.leastFindCreateGradientLayer(bounds: .zero)

    // MARK: - UI Components
    private lazy var leastFindHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = LeastFindTheme.leastFindCardBackgroundColor
        LeastFindTheme.leastFindApplyShadow(to: view, opacity: 0.3, radius: 8)
        return view
    }()

    private lazy var leastFindBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("← Back", for: .normal)
        button.setTitleColor(LeastFindTheme.leastFindSecondaryColor, for: .normal)
        button.titleLabel?.font = LeastFindTheme.leastFindButtonFont(size: 18)
        button.addTarget(self, action: #selector(leastFindBackButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var leastFindTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "⚙️ Settings"
        label.font = LeastFindTheme.leastFindTitleFont(size: 28)
        label.textColor = LeastFindTheme.leastFindGoldTextColor
        label.textAlignment = .center
        return label
    }()

    private lazy var leastFindScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var leastFindContentView: UIView = {
        return UIView()
    }()

    private lazy var leastFindInstructionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("📖 How to Play", for: .normal)
        button.leastFindApplySecondaryStyle()
        button.addTarget(self, action: #selector(leastFindShowInstructions), for: .touchUpInside)
        return button
    }()

    private lazy var leastFindRateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⭐️ Rate This Game", for: .normal)
        button.leastFindApplySecondaryStyle()
        button.addTarget(self, action: #selector(leastFindRateApp), for: .touchUpInside)
        return button
    }()

    private lazy var leastFindFeedbackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("💬 Send Feedback", for: .normal)
        button.leastFindApplySecondaryStyle()
        button.addTarget(self, action: #selector(leastFindSendFeedback), for: .touchUpInside)
        return button
    }()

    private lazy var leastFindVersionLabel: UILabel = {
        let label = UILabel()
        label.text = "Version 1.0.0"
        label.font = LeastFindTheme.leastFindBodyFont(size: 14)
        label.textColor = LeastFindTheme.leastFindSecondaryTextColor
        label.textAlignment = .center
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        leastFindSetupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        leastFindGradientLayer.frame = view.bounds
    }

    // MARK: - Setup
    private func leastFindSetupUI() {
        view.layer.insertSublayer(leastFindGradientLayer, at: 0)

        view.addSubview(leastFindHeaderView)
        leastFindHeaderView.addSubview(leastFindBackButton)
        leastFindHeaderView.addSubview(leastFindTitleLabel)

        view.addSubview(leastFindScrollView)
        leastFindScrollView.addSubview(leastFindContentView)

        leastFindContentView.addSubview(leastFindInstructionsButton)
        leastFindContentView.addSubview(leastFindRateButton)
        leastFindContentView.addSubview(leastFindFeedbackButton)
        leastFindContentView.addSubview(leastFindVersionLabel)

        leastFindSetupConstraints()
    }

    private func leastFindSetupConstraints() {
        leastFindHeaderView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(120)
        }

        leastFindBackButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(44)
        }

        leastFindTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(leastFindBackButton)
            make.centerX.equalToSuperview()
        }

        leastFindScrollView.snp.makeConstraints { make in
            make.top.equalTo(leastFindHeaderView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        leastFindContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }

        leastFindInstructionsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }

        leastFindRateButton.snp.makeConstraints { make in
            make.top.equalTo(leastFindInstructionsButton.snp.bottom).offset(20)
            make.left.right.height.equalTo(leastFindInstructionsButton)
        }

        leastFindFeedbackButton.snp.makeConstraints { make in
            make.top.equalTo(leastFindRateButton.snp.bottom).offset(20)
            make.left.right.height.equalTo(leastFindInstructionsButton)
        }

        leastFindVersionLabel.snp.makeConstraints { make in
            make.top.equalTo(leastFindFeedbackButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
    }

    // MARK: - Actions
    @objc private func leastFindBackButtonTapped() {
        dismiss(animated: true)
    }

    @objc private func leastFindShowInstructions() {
        let instructionsVC = LeastFindInstructionsViewController()
        instructionsVC.modalPresentationStyle = .fullScreen
        present(instructionsVC, animated: true)
    }

    @objc private func leastFindRateApp() {
        let alert = UIAlertController(title: "Rate Mahjong Spot It", message: "Thank you for playing! Please rate us on the App Store.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Rate Now", style: .default) { _ in
            // In a real app, this would open the App Store
            print("Opening App Store for rating")
        })
        alert.addAction(UIAlertAction(title: "Later", style: .cancel))
        present(alert, animated: true)
    }

    @objc private func leastFindSendFeedback() {
        let alert = UIAlertController(title: "Send Feedback", message: "We'd love to hear from you!", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Your feedback..."
        }
        alert.addAction(UIAlertAction(title: "Send", style: .default) { [weak alert] _ in
            guard let feedback = alert?.textFields?.first?.text, !feedback.isEmpty else { return }
            print("Feedback: \(feedback)")

            let thanks = UIAlertController(title: "Thank You!", message: "Your feedback has been received.", preferredStyle: .alert)
            thanks.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(thanks, animated: true)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

// MARK: - Instructions View Controller
class LeastFindInstructionsViewController: UIViewController {

    private let leastFindGradientLayer = LeastFindTheme.leastFindCreateGradientLayer(bounds: .zero)

    private lazy var leastFindBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✕", for: .normal)
        button.setTitleColor(LeastFindTheme.leastFindPrimaryTextColor, for: .normal)
        button.titleLabel?.font = LeastFindTheme.leastFindTitleFont(size: 28)
        button.addTarget(self, action: #selector(leastFindClose), for: .touchUpInside)
        return button
    }()

    private lazy var leastFindScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()

    private lazy var leastFindContentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = LeastFindTheme.leastFindBodyFont(size: 16)
        label.textColor = LeastFindTheme.leastFindPrimaryTextColor

        let instructions = """
        HOW TO PLAY

        Mahjong Spot It is a fast-paced puzzle game where you need to identify tiles that don't belong!

        🎮 GAME MODES

        • 3×3: Find 1-4 odd tiles from 9 total
          Base score: 20 points

        • 4×4: Find 1-7 odd tiles from 16 total
          Base score: 40 points

        • 5×5: Find 1-12 odd tiles from 25 total
          Base score: 50 points

        📋 RULES

        1. Each round shows a grid of mahjong tiles

        2. Most tiles are the SAME type (筒/Ciueyu, 万/Woama, or 条/Goirius)

        3. Some tiles are DIFFERENT types - these are the "odd ones out"

        4. Tap all the odd tiles to complete the round

        5. ⚠️ WARNING: If you tap a wrong tile, GAME OVER!
           Your score will be reset to zero

        6. Complete all odd tiles correctly to score points and continue!

        🔥 COMBO SYSTEM

        • Complete 3 rounds in a row correctly to start a combo
        • Each additional combo multiplies your score
        • Combo x3: +20% bonus
        • Combo x4: +40% bonus
        • And so on...
        • One mistake resets everything!

        💡 TIPS

        • Take your time - accuracy is EVERYTHING!
        • Look for the majority type first
        • One mistake = game over & score reset
        • Higher difficulty = higher scores
        • Build combos for massive points

        Good luck and be careful! 🎯
        """

        label.text = instructions
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        leastFindSetupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        leastFindGradientLayer.frame = view.bounds
    }

    private func leastFindSetupUI() {
        view.layer.insertSublayer(leastFindGradientLayer, at: 0)

        view.addSubview(leastFindBackButton)
        view.addSubview(leastFindScrollView)
        leastFindScrollView.addSubview(leastFindContentLabel)

        leastFindBackButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(44)
        }

        leastFindScrollView.snp.makeConstraints { make in
            make.top.equalTo(leastFindBackButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        leastFindContentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(30)
            make.width.equalTo(view).offset(-60)
        }
    }

    @objc private func leastFindClose() {
        dismiss(animated: true)
    }
}
