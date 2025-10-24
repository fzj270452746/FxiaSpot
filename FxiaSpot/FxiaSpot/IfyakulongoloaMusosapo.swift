
import UIKit
import SnapKit

class IfyakulongoloaMusosapo: UIViewController {
    private let ipupaNsoselo = NsoseloUmulamboMupangapo.ipupaShared
    private lazy var ipupaGradient = ipupaNsoselo.ipupaBulukaGradient(ubwalwa: .zero)

    private lazy var ipupaMutweView: UIView = {
        let v = UIView()
        v.backgroundColor = ipupaNsoselo.ipupaTwalaLangiCard()
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor(white: 1.0, alpha: 0.2).cgColor
        ipupaNsoselo.ipupaBikaShadow(paBwino: v, opacity: 0.3, radius: 10)
        return v
    }()

    private lazy var ipupaCikansamBuyafye: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("← Back", for: .normal)
        b.setTitleColor(ipupaNsoselo.ipupaTwalaLangiSecondary(), for: .normal)
        b.titleLabel?.font = ipupaNsoselo.ipupaBulukaFontCikansambo(ubunene: 18)
        b.addTarget(self, action: #selector(ipupaBuyafyedwa), for: .touchUpInside)
        return b
    }()

    private lazy var ipupaMutwe: UILabel = {
        let l = UILabel()
        l.text = "⚙️ Settings"
        l.font = ipupaNsoselo.ipupaBulukaFontMutwe(ubunene: 32)
        l.textColor = ipupaNsoselo.ipupaTwalaLangiGold()
        l.textAlignment = .center

        // 添加发光效果
        ipupaNsoselo.ipupaBikaGlow(paBwino: l, langi: ipupaNsoselo.ipupaTwalaLangiGold(), radius: 16, opacity: 0.6)

        return l
    }()

    private lazy var ipupaScroll: UIScrollView = {
        let s = UIScrollView()
        s.showsVerticalScrollIndicator = false
        return s
    }()

    private lazy var ipupaContent: UIView = UIView()

    private lazy var ipupaCikansamboInstructions: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("📖 How to Play", for: .normal)
        b.setTitleColor(ipupaNsoselo.ipupaTwalaLangiText(), for: .normal)
        b.titleLabel?.font = ipupaNsoselo.ipupaBulukaFontCikansambo(ubunene: 18)
        b.backgroundColor = ipupaNsoselo.ipupaTwalaLangiCard()
        b.layer.cornerRadius = 28  // 胶囊形状
        b.layer.borderWidth = 2
        b.layer.borderColor = ipupaNsoselo.ipupaTwalaLangiSecondary().withAlphaComponent(0.4).cgColor
        ipupaNsoselo.ipupaBikaShadow(paBwino: b, opacity: 0.3, radius: 10)
        b.addTarget(self, action: #selector(ipupaSongeshaInstructions), for: .touchUpInside)
        return b
    }()

    private lazy var ipupaCikansamboRate: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("⭐️ Rate This Game", for: .normal)
        b.setTitleColor(ipupaNsoselo.ipupaTwalaLangiText(), for: .normal)
        b.titleLabel?.font = ipupaNsoselo.ipupaBulukaFontCikansambo(ubunene: 18)
        b.backgroundColor = ipupaNsoselo.ipupaTwalaLangiCard()
        b.layer.cornerRadius = 28  // 胶囊形状
        b.layer.borderWidth = 2
        b.layer.borderColor = ipupaNsoselo.ipupaTwalaLangiSecondary().withAlphaComponent(0.4).cgColor
        ipupaNsoselo.ipupaBikaShadow(paBwino: b, opacity: 0.3, radius: 10)
        b.addTarget(self, action: #selector(ipupaRate), for: .touchUpInside)
        return b
    }()

    private lazy var ipupaCikansamboFeedback: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("💬 Send Feedback", for: .normal)
        b.setTitleColor(ipupaNsoselo.ipupaTwalaLangiText(), for: .normal)
        b.titleLabel?.font = ipupaNsoselo.ipupaBulukaFontCikansambo(ubunene: 18)
        b.backgroundColor = ipupaNsoselo.ipupaTwalaLangiCard()
        b.layer.cornerRadius = 28  // 胶囊形状
        b.layer.borderWidth = 2
        b.layer.borderColor = ipupaNsoselo.ipupaTwalaLangiSecondary().withAlphaComponent(0.4).cgColor
        ipupaNsoselo.ipupaBikaShadow(paBwino: b, opacity: 0.3, radius: 10)
        b.addTarget(self, action: #selector(ipupaFeedback), for: .touchUpInside)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        ipupaPanga()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ipupaGradient.frame = view.bounds
    }

    private func ipupaPanga() {
        view.layer.insertSublayer(ipupaGradient, at: 0)
        view.addSubview(ipupaMutweView)
        ipupaMutweView.addSubview(ipupaCikansamBuyafye)
        ipupaMutweView.addSubview(ipupaMutwe)
        view.addSubview(ipupaScroll)
        ipupaScroll.addSubview(ipupaContent)
        ipupaContent.addSubview(ipupaCikansamboInstructions)
        ipupaContent.addSubview(ipupaCikansamboRate)
        ipupaContent.addSubview(ipupaCikansamboFeedback)

        ipupaMutweView.snp.makeConstraints { $0.top.left.right.equalToSuperview(); $0.height.equalTo(130) }
        ipupaCikansamBuyafye.snp.makeConstraints { $0.top.equalTo(view.safeAreaLayoutGuide).offset(12); $0.left.equalToSuperview().offset(20); $0.height.equalTo(44) }
        ipupaMutwe.snp.makeConstraints { $0.centerY.equalTo(ipupaCikansamBuyafye); $0.centerX.equalToSuperview() }
        ipupaScroll.snp.makeConstraints { $0.top.equalTo(ipupaMutweView.snp.bottom); $0.left.right.equalToSuperview(); $0.bottom.equalTo(view.safeAreaLayoutGuide) }
        ipupaContent.snp.makeConstraints { $0.edges.equalToSuperview(); $0.width.equalTo(view) }
        ipupaCikansamboInstructions.snp.makeConstraints { $0.top.equalToSuperview().offset(40); $0.left.equalToSuperview().offset(50); $0.right.equalToSuperview().offset(-50); $0.height.equalTo(56) }
        ipupaCikansamboRate.snp.makeConstraints { $0.top.equalTo(ipupaCikansamboInstructions.snp.bottom).offset(24); $0.left.right.height.equalTo(ipupaCikansamboInstructions) }
        ipupaCikansamboFeedback.snp.makeConstraints { $0.top.equalTo(ipupaCikansamboRate.snp.bottom).offset(24); $0.left.right.height.equalTo(ipupaCikansamboInstructions); $0.bottom.equalToSuperview().offset(-40) }
    }

    @objc private func ipupaBuyafyedwa() {
        dismiss(animated: true)
    }

    @objc private func ipupaSongeshaInstructions() {
        let vc = IpupaInstructionsMusosapo()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

    @objc private func ipupaRate() {
        let alert = UIAlertController(title: "Rate Mahjong Spot It", message: "Thank you for playing!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Rate Now", style: .default) { _ in })
        alert.addAction(UIAlertAction(title: "Later", style: .cancel))
        present(alert, animated: true)
    }

    @objc private func ipupaFeedback() {
        let alert = UIAlertController(title: "Send Feedback", message: "We'd love to hear from you!", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Your feedback..." }
        alert.addAction(UIAlertAction(title: "Send", style: .default) { [weak self] _ in
            let thanks = UIAlertController(title: "Thank You!", message: "Your feedback has been received.", preferredStyle: .alert)
            thanks.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(thanks, animated: true)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

class IpupaInstructionsMusosapo: UIViewController {
    private let ipupaNsoselo = NsoseloUmulamboMupangapo.ipupaShared
    private lazy var ipupaGradient = ipupaNsoselo.ipupaBulukaGradient(ubwalwa: .zero)

    private lazy var ipupaCikansamPitya: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("✕", for: .normal)
        b.setTitleColor(ipupaNsoselo.ipupaTwalaLangiText(), for: .normal)
        b.titleLabel?.font = ipupaNsoselo.ipupaBulukaFontMutwe(ubunene: 28)
        b.addTarget(self, action: #selector(ipupaPitya), for: .touchUpInside)
        return b
    }()

    private lazy var ipupaScroll: UIScrollView = {
        let s = UIScrollView()
        s.showsVerticalScrollIndicator = true
        return s
    }()

    private lazy var ipupaItondo: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = ipupaNsoselo.ipupaBulukaFontUmubili(ubunene: 16)
        l.textColor = ipupaNsoselo.ipupaTwalaLangiText()
        l.text = """
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
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        ipupaPanga()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ipupaGradient.frame = view.bounds
    }

    private func ipupaPanga() {
        view.layer.insertSublayer(ipupaGradient, at: 0)
        view.addSubview(ipupaCikansamPitya)
        view.addSubview(ipupaScroll)
        ipupaScroll.addSubview(ipupaItondo)

        ipupaCikansamPitya.snp.makeConstraints { $0.top.equalTo(view.safeAreaLayoutGuide).offset(10); $0.right.equalToSuperview().offset(-20); $0.width.height.equalTo(44) }
        ipupaScroll.snp.makeConstraints { $0.top.equalTo(ipupaCikansamPitya.snp.bottom).offset(10); $0.left.right.equalToSuperview(); $0.bottom.equalTo(view.safeAreaLayoutGuide) }
        ipupaItondo.snp.makeConstraints { $0.edges.equalToSuperview().inset(30); $0.width.equalTo(view).offset(-60) }
    }

    @objc private func ipupaPitya() {
        dismiss(animated: true)
    }
}
