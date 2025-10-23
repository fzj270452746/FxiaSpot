

import UIKit
import SnapKit

class HeixnYosuxiZHuswViewController: UIViewController {

    // MARK: - Properties
    private let zuixshaMode: XdsiduGameMode
    private var yoxluojiGameLogic: GaursnYoxLogicyi!
    private var zhusntaiGameState: OkseyyaGameState!
    private var diauwvTileViews: [LeastFindTileView] = []
    private var dhauseCurrentTiles: [uansdKsjsMahjongTile] = []
    private let bchausdGradientLayer = LeastFindTheme.leastFindCreateGradientLayer(bounds: .zero)
    private var laizisuParticleEmitter: CAEmitterLayer?

    // MARK: - UI Components
    private lazy var touzbusHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = LeastFindTheme.leastFindCardBackgroundColor
        LeastFindTheme.leastFindApplyShadow(to: view, opacity: 0.3, radius: 8)
        return view
    }()

    private lazy var gaunzbsiCloseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✕", for: .normal)
        button.setTitleColor(LeastFindTheme.leastFindPrimaryTextColor, for: .normal)
        button.titleLabel?.font = LeastFindTheme.leastFindTitleFont(size: 28)
        button.addTarget(self, action: #selector(guanchewisCloseButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var shuzfenScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score: 0"
        label.font = LeastFindTheme.leastFindTitleFont(size: 22)
        label.textColor = LeastFindTheme.leastFindGoldTextColor
        label.textAlignment = .center
        return label
    }()

    private lazy var jilaisneComboLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = LeastFindTheme.leastFindButtonFont(size: 16)
        label.textColor = LeastFindTheme.leastFindAccentColor
        label.textAlignment = .center
        label.alpha = 0
        return label
    }()

    private lazy var wnagegeGridContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var lsinjaHintLabel: UILabel = {
        let label = UILabel()
        label.text = "Find tiles that are NOT the majority type!\n⚠️ One wrong tap = Game Over!"
        label.font = LeastFindTheme.leastFindBodyFont(size: 14)
        label.textColor = LeastFindTheme.leastFindSecondaryTextColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var zhichosneResetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Round", for: .normal)
        button.leastFindApplySecondaryStyle()
        button.addTarget(self, action: #selector(chaizeeResetButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Init
    init(leastFindMode: XdsiduGameMode) {
        self.zuixshaMode = leastFindMode
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        donqiesSetupGame()
        zhuansASSSetupUI()
        qikaisxneStartNewRound()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bchausdGradientLayer.frame = view.bounds
    }

    // MARK: - Setup
    private func donqiesSetupGame() {
        yoxluojiGameLogic = GaursnYoxLogicyi(leastFindMode: zuixshaMode)
        zhusntaiGameState = OkseyyaGameState(leastFindMode: zuixshaMode)
    }

    private func zhuansASSSetupUI() {
        view.layer.insertSublayer(bchausdGradientLayer, at: 0)

        view.addSubview(touzbusHeaderView)
        touzbusHeaderView.addSubview(gaunzbsiCloseButton)
        touzbusHeaderView.addSubview(shuzfenScoreLabel)
        touzbusHeaderView.addSubview(jilaisneComboLabel)

        view.addSubview(wnagegeGridContainerView)
        view.addSubview(lsinjaHintLabel)
        view.addSubview(zhichosneResetButton)

        yushuyANahsConstraints()
    }

    private func yushuyANahsConstraints() {
        touzbusHeaderView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(140)
        }

        gaunzbsiCloseButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(44)
        }

        shuzfenScoreLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }

        jilaisneComboLabel.snp.makeConstraints { make in
            make.top.equalTo(shuzfenScoreLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        wnagegeGridContainerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(suanjsdaxiCalculateGridSize())
        }

        lsinjaHintLabel.snp.makeConstraints { make in
            make.bottom.equalTo(zhichosneResetButton.snp.top).offset(-20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }

        zhichosneResetButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }
    }

    private func suanjsdaxiCalculateGridSize() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let availableSpace = min(screenWidth - 60, screenHeight - 300)
        return availableSpace
    }

    private func cjianchauCreateGridView() {
        // Clear existing tiles
        diauwvTileViews.forEach { $0.removeFromSuperview() }
        diauwvTileViews.removeAll()

        let gridSize = zuixshaMode.leastFindGridSize
        let spacing: CGFloat = 8
        let totalSpacing = CGFloat(gridSize - 1) * spacing
        let containerSize = suanjsdaxiCalculateGridSize()
        let tileSize = (containerSize - totalSpacing) / CGFloat(gridSize)

        for row in 0..<gridSize {
            for col in 0..<gridSize {
                let index = row * gridSize + col
                let tileView = LeastFindTileView()
                tileView.leastFindOnTap = { [weak self] in
                    self?.nshaeiHandleTileTap(at: index)
                }

                wnagegeGridContainerView.addSubview(tileView)
                tileView.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(CGFloat(col) * (tileSize + spacing))
                    make.top.equalToSuperview().offset(CGFloat(row) * (tileSize + spacing))
                    make.width.height.equalTo(tileSize)
                }

                diauwvTileViews.append(tileView)

                // Entrance animation
                tileView.alpha = 0
                tileView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                UIView.animate(withDuration: 0.4, delay: Double(index) * 0.03, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                    tileView.alpha = 1
                    tileView.transform = .identity
                })
            }
        }
    }

    // MARK: - Game Logic
    private func qikaisxneStartNewRound() {
        dhauseCurrentTiles = yoxluojiGameLogic.abuudsGenerateTiles()
        cjianchauCreateGridView()

        for (index, tile) in dhauseCurrentTiles.enumerated() {
            diauwvTileViews[index].leastFindConfigure(with: tile)
        }

        xingennUpdateUI()
    }

    private func nshaeiHandleTileTap(at index: Int) {
        guard index < dhauseCurrentTiles.count else { return }

        let tile = dhauseCurrentTiles[index]
        let tileView = diauwvTileViews[index]

        // Check if already in correct or wrong state
        if tileView.leastFindState == .leastFindCorrect || tileView.leastFindState == .leastFindWrong {
            return
        }

        let isCorrect = yoxluojiGameLogic.vaosiejIsCorrectSelection(tile)

        if isCorrect {
            tileView.leastFindState = .leastFindCorrect
            yoxluojiGameLogic.gateyasRemoveFromMinority(tile)

            // Check if round complete
            if yoxluojiGameLogic.kaoiessIsRoundComplete() {
                hehuiawanchHandleRoundComplete(success: true)
            }
        } else {
            tileView.leastFindState = .leastFindWrong
            hehuiawanchHandleRoundComplete(success: false)
        }
    }

    private func hehuiawanchHandleRoundComplete(success: Bool) {
        if success {
            let scoreAdded = zhusntaiGameState.suanjhsiaCalculateScore(isCorrect: success)
            donhghauxianhowSuccessAnimation(scoreAdded: scoreAdded)
            lizisuchCreateParticleEffect()
            xingennUpdateUI()

            // Auto start new round after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                self?.qikaisxneStartNewRound()
            }
        } else {
            // Game Over - show failure and reset
            jieshyasShowGameOverMessage()

            // Save current score before reset if it's greater than 0
            if zhusntaiGameState.dangqianCurrentScore > 0 {
                LeastFindLeaderboardManager.leastFindShared.leastFindSaveScore(zhusntaiGameState.dangqianCurrentScore, for: zuixshaMode)
            }

            // Reset game state
            zhusntaiGameState.choqisResetGame()
            xingennUpdateUI()

            // Start new game after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
                self?.qikaisxneStartNewRound()
            }
        }
    }

    private func xingennUpdateUI() {
        shuzfenScoreLabel.text = "Score: \(zhusntaiGameState.dangqianCurrentScore)"

        if zhusntaiGameState.lianjsComboCount >= 3 {
            jilaisneComboLabel.text = "🔥 Combo x\(zhusntaiGameState.lianjsComboCount)"
            UIView.animate(withDuration: 0.3) {
                self.jilaisneComboLabel.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.jilaisneComboLabel.alpha = 0
            }
        }
    }

    // MARK: - Animations
    private func donhghauxianhowSuccessAnimation(scoreAdded: Int) {
        let label = UILabel()
        label.text = "+\(scoreAdded)"
        label.font = LeastFindTheme.leastFindTitleFont(size: 40)
        label.textColor = LeastFindTheme.leastFindGoldTextColor
        label.textAlignment = .center
        LeastFindTheme.leastFindApplyShadow(to: label, color: .black, opacity: 0.5, radius: 10)

        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        label.alpha = 0
        label.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [], animations: {
            label.alpha = 1
            label.transform = .identity
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 0.5, animations: {
                label.alpha = 0
                label.transform = CGAffineTransform(translationX: 0, y: -50)
            }) { _ in
                label.removeFromSuperview()
            }
        }
    }

    private func jieshyasShowGameOverMessage() {
        // Dim background
        let dimView = UIView()
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        dimView.alpha = 0
        view.addSubview(dimView)
        dimView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // Container for message
        let containerView = UIView()
        containerView.backgroundColor = LeastFindTheme.leastFindCardBackgroundColor
        containerView.layer.cornerRadius = 20
        LeastFindTheme.leastFindApplyShadow(to: containerView, opacity: 0.5, radius: 20)
        view.addSubview(containerView)

        // Game Over title
        let titleLabel = UILabel()
        titleLabel.text = "GAME OVER"
        titleLabel.font = LeastFindTheme.leastFindTitleFont(size: 36)
        titleLabel.textColor = LeastFindTheme.leastFindWrongColor
        titleLabel.textAlignment = .center

        // Score label
        let scoreLabel = UILabel()
        let finalScore = zhusntaiGameState.dangqianCurrentScore
        scoreLabel.text = "Final Score: \(finalScore)"
        scoreLabel.font = LeastFindTheme.leastFindTitleFont(size: 24)
        scoreLabel.textColor = LeastFindTheme.leastFindGoldTextColor
        scoreLabel.textAlignment = .center

        // Message label
        let messageLabel = UILabel()
        if finalScore > 0 {
            messageLabel.text = "Nice try!\nYour score has been saved."
        } else {
            messageLabel.text = "Wrong on first try!\nStarting over..."
        }
        messageLabel.font = LeastFindTheme.leastFindBodyFont(size: 16)
        messageLabel.textColor = LeastFindTheme.leastFindSecondaryTextColor
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0

        containerView.addSubview(titleLabel)
        containerView.addSubview(scoreLabel)
        containerView.addSubview(messageLabel)

        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }

        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-30)
        }

        // Animations
        containerView.alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

        UIView.animate(withDuration: 0.3, animations: {
            dimView.alpha = 1
            containerView.alpha = 1
            containerView.transform = .identity
        }) { _ in
            // Shake animation for emphasis
            let shake = CAKeyframeAnimation(keyPath: "transform.rotation")
            shake.values = [-0.05, 0.05, -0.05, 0.05, 0]
            shake.duration = 0.5
            containerView.layer.add(shake, forKey: "leastFindShake")

            // Fade out after delay
            UIView.animate(withDuration: 0.3, delay: 1.3, animations: {
                dimView.alpha = 0
                containerView.alpha = 0
                containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }) { _ in
                dimView.removeFromSuperview()
                containerView.removeFromSuperview()
            }
        }
    }

    private func lizisuchCreateParticleEffect() {
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        emitter.emitterShape = .circle
        emitter.emitterSize = CGSize(width: 100, height: 100)

        let cell = CAEmitterCell()
        cell.birthRate = 50
        cell.lifetime = 2.0
        cell.velocity = 150
        cell.velocityRange = 50
        cell.emissionRange = .pi * 2
        cell.scale = 0.1
        cell.scaleRange = 0.05
        cell.alphaSpeed = -0.5

        // Create a simple particle image
        cell.contents = vxvqwwCreateParticleImage().cgImage
        cell.color = LeastFindTheme.leastFindGoldTextColor.cgColor

        emitter.emitterCells = [cell]
        view.layer.addSublayer(emitter)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            emitter.birthRate = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            emitter.removeFromSuperlayer()
        }
    }

    private func vxvqwwCreateParticleImage() -> UIImage {
        let size = CGSize(width: 10, height: 10)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()!

        context.setFillColor(UIColor.white.cgColor)
        context.fillEllipse(in: CGRect(origin: .zero, size: size))

        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    // MARK: - Actions
    @objc private func guanchewisCloseButtonTapped() {
        // Save score if any
        if zhusntaiGameState.dangqianCurrentScore > 0 {
            LeastFindLeaderboardManager.leastFindShared.leastFindSaveScore(zhusntaiGameState.dangqianCurrentScore, for: zuixshaMode)
        }

        dismiss(animated: true)
    }

    @objc private func chaizeeResetButtonTapped() {
        qikaisxneStartNewRound()
    }
}
