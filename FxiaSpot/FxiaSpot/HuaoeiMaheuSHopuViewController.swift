
import UIKit
import SnapKit

class HuaoeiMaheuSHopuViewController: UIViewController {

    // MARK: - UI Components
    private let nzusyeGradientLayer = LeastFindTheme.leastFindCreateGradientLayer(bounds: .zero)

    private lazy var ayzuasTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mahjong Spot It"
        label.font = LeastFindTheme.leastFindTitleFont(size: 38)
        label.textColor = LeastFindTheme.leastFindGoldTextColor
        label.textAlignment = .center
        label.numberOfLines = 0
        LeastFindTheme.leastFindApplyShadow(to: label, color: .black, opacity: 0.5, radius: 10)
        return label
    }()

    private lazy var bzauuddSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Find the Odd Ones Out!"
        label.font = LeastFindTheme.leastFindBodyFont(size: 16)
        label.textColor = LeastFindTheme.leastFindSecondaryColor
        label.textAlignment = .center
        return label
    }()

    private lazy var oaieksGameModeStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var awuues3x3Button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("3 × 3", for: .normal)
        button.leastFindApplyGameModeStyle()
        button.addTarget(self, action: #selector(akeousyGameModeButtonTapped(_:)), for: .touchUpInside)
        button.tag = 0
        return button
    }()

    private lazy var ayyush4x4Button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("4 × 4", for: .normal)
        button.leastFindApplyGameModeStyle()
        button.addTarget(self, action: #selector(akeousyGameModeButtonTapped(_:)), for: .touchUpInside)
        button.tag = 1
        return button
    }()

    private lazy var oaejsue5x5Button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("5 × 5", for: .normal)
        button.leastFindApplyGameModeStyle()
        button.addTarget(self, action: #selector(akeousyGameModeButtonTapped(_:)), for: .touchUpInside)
        button.tag = 2
        return button
    }()

    private lazy var hangaissLeaderboardButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🏆 Leaderboard", for: .normal)
        button.leastFindApplySecondaryStyle()
        button.addTarget(self, action: #selector(atterqwLeaderboardButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var zhisheaysSettingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⚙️ Settings", for: .normal)
        button.leastFindApplySecondaryStyle()
        button.addTarget(self, action: #selector(leastFindSettingsButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        aoeiajsSetupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nzusyeGradientLayer.frame = view.bounds
    }

    // MARK: - Setup
    private func aoeiajsSetupUI() {
        view.layer.insertSublayer(nzusyeGradientLayer, at: 0)

        view.addSubview(ayzuasTitleLabel)
        view.addSubview(bzauuddSubtitleLabel)
        view.addSubview(oaieksGameModeStackView)
        view.addSubview(hangaissLeaderboardButton)
        view.addSubview(zhisheaysSettingsButton)

        oaieksGameModeStackView.addArrangedSubview(awuues3x3Button)
        oaieksGameModeStackView.addArrangedSubview(ayyush4x4Button)
        oaieksGameModeStackView.addArrangedSubview(oaejsue5x5Button)

        akeousyeSetupConstraints()
        ayettasAddAnimations()
    }

    private func akeousyeSetupConstraints() {
        ayzuasTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview().offset(20)
            make.right.lessThanOrEqualToSuperview().offset(-20)
        }

        bzauuddSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(ayzuasTitleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        oaieksGameModeStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.lessThanOrEqualTo(400)
        }

        hangaissLeaderboardButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.bottom.equalTo(zhisheaysSettingsButton.snp.top).offset(-15)
            make.height.equalTo(50)
        }

        zhisheaysSettingsButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(50)
        }
    }

    private func ayettasAddAnimations() {
        // Pulse animation for title
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.duration = 2.0
        pulse.fromValue = 1.0
        pulse.toValue = 1.05
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        ayzuasTitleLabel.layer.add(pulse, forKey: "leastFindPulse")
    }

    // MARK: - Actions
    @objc private func akeousyGameModeButtonTapped(_ sender: UIButton) {
        loaiiesAnimateButtonPress(sender)

        let mode: XdsiduGameMode
        switch sender.tag {
        case 0: mode = .threeByThree
        case 1: mode = .fourByFour
        case 2: mode = .fiveByFive
        default: return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            let gameVC = HeixnYosuxiZHuswViewController(leastFindMode: mode)
            gameVC.modalPresentationStyle = .fullScreen
            self?.present(gameVC, animated: true)
        }
    }

    @objc private func atterqwLeaderboardButtonTapped() {
        loaiiesAnimateButtonPress(hangaissLeaderboardButton)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            let leaderboardVC = LeastFindLeaderboardViewController()
            leaderboardVC.modalPresentationStyle = .fullScreen
            self?.present(leaderboardVC, animated: true)
        }
    }

    @objc private func leastFindSettingsButtonTapped() {
        loaiiesAnimateButtonPress(zhisheaysSettingsButton)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            let settingsVC = LeastFindSettingsViewController()
            settingsVC.modalPresentationStyle = .fullScreen
            self?.present(settingsVC, animated: true)
        }
    }

    private func loaiiesAnimateButtonPress(_ button: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                button.transform = .identity
            }
        }
    }
}
