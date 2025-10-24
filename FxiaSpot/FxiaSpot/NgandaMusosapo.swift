

import UIKit
import SnapKit
import Reachability

// ViewModel for home screen
class IpupaNgandaViewModel {
    private let ipupaNsoselo = NsoseloUmulamboMupangapo.ipupaShared

    struct IpupaCikansamboModel {
        let ishina: String
        let icibabo: IpupaIcibaboFactory.IpupaIcibaboType
        let tag: Int
    }

    func ipupaTwalaCikansambo() -> [IpupaCikansamboModel] {
        return [
            IpupaCikansamboModel(ishina: "3 × 3", icibabo: .tatu, tag: 0),
            IpupaCikansamboModel(ishina: "4 × 4", icibabo: .na, tag: 1),
            IpupaCikansamboModel(ishina: "5 × 5", icibabo: .sano, tag: 2)
        ]
    }

    func ipupaTwalaItondo() -> String {
        return "Mahjong Spot It"
    }

    func ipupaTwalaSubtitle() -> String {
        return "Find the Odd Ones Out!"
    }
}

import Zqingwu

// Main home view controller
class NgandaMusosapo: UIViewController {
    private let ipupaViewModel = IpupaNgandaViewModel()
    private let ipupaNsoselo = NsoseloUmulamboMupangapo.ipupaShared
    private lazy var ipupaGradient = ipupaNsoselo.ipupaBulukaGradient(ubwalwa: .zero)

    // MARK: - UI Components

    // 装饰圆圈
    private lazy var decorativeCircle1: UIView = {
        let view = UIView()
        view.backgroundColor = ipupaNsoselo.ipupaTwalaLangiSecondary().withAlphaComponent(0.1)
        view.layer.cornerRadius = 150
        return view
    }()

    private lazy var decorativeCircle2: UIView = {
        let view = UIView()
        view.backgroundColor = ipupaNsoselo.ipupaTwalaLangiAccent().withAlphaComponent(0.08)
        view.layer.cornerRadius = 100
        return view
    }()

    // 主标题容器卡片
    private lazy var titleCard: UIView = {
        let card = UIView()
        card.backgroundColor = ipupaNsoselo.ipupaTwalaLangiCard()
        card.layer.cornerRadius = 30
        card.layer.borderWidth = 2
        card.layer.borderColor = ipupaNsoselo.ipupaTwalaLangiSecondary().withAlphaComponent(0.3).cgColor
        ipupaNsoselo.ipupaBikaShadow(paBwino: card, opacity: 0.4, radius: 20)
        return card
    }()

    private lazy var ipupaMutwe: UILabel = {
        let label = UILabel()
        label.text = ipupaViewModel.ipupaTwalaItondo()
        label.font = ipupaNsoselo.ipupaBulukaFontMutwe(ubunene: 40)
        label.textColor = ipupaNsoselo.ipupaTwalaLangiGold()
        label.textAlignment = .center
        label.numberOfLines = 0

        // 添加发光效果
        ipupaNsoselo.ipupaBikaGlow(paBwino: label, langi: ipupaNsoselo.ipupaTwalaLangiGold(), radius: 20, opacity: 0.7)

        return label
    }()

    private lazy var ipupaShaniMutwe: UILabel = {
        let label = UILabel()
        label.text = ipupaViewModel.ipupaTwalaSubtitle()
        label.font = ipupaNsoselo.ipupaBulukaFontUmubili(ubunene: 16)
        label.textColor = ipupaNsoselo.ipupaTwalaLangiTextSecondary()
        label.textAlignment = .center
        return label
    }()

    // 游戏模式卡片容器
    private lazy var gameModeCard: UIView = {
        let card = UIView()
        card.backgroundColor = ipupaNsoselo.ipupaTwalaLangiCard()
        card.layer.cornerRadius = 25
        card.layer.borderWidth = 1.5
        card.layer.borderColor = UIColor(white: 1.0, alpha: 0.15).cgColor
        ipupaNsoselo.ipupaBikaShadow(paBwino: card, opacity: 0.3, radius: 15)
        return card
    }()

    private lazy var ipupaStackIcibabo: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 18
        stack.distribution = .fillEqually
        return stack
    }()

    private var ipupaFyakansambo: [UIButton] = []

    private lazy var ipupaCikansamboUkutunguluka: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("🏆 Leaderboard", for: .normal)
        btn.setTitleColor(ipupaNsoselo.ipupaTwalaLangiText(), for: .normal)
        btn.titleLabel?.font = ipupaNsoselo.ipupaBulukaFontCikansambo(ubunene: 18)
        btn.backgroundColor = ipupaNsoselo.ipupaTwalaLangiCard()
        btn.layer.borderWidth = 2
        btn.layer.borderColor = ipupaNsoselo.ipupaTwalaLangiSecondary().withAlphaComponent(0.4).cgColor
        btn.clipsToBounds = true
        ipupaNsoselo.ipupaBikaShadow(paBwino: btn, opacity: 0.3, radius: 10)
        btn.addTarget(self, action: #selector(ipupaUkutungulukaShitedwa), for: .touchUpInside)
        return btn
    }()

    private lazy var ipupaCikansamboIfyakulongolola: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("⚙️ Settings", for: .normal)
        btn.setTitleColor(ipupaNsoselo.ipupaTwalaLangiText(), for: .normal)
        btn.titleLabel?.font = ipupaNsoselo.ipupaBulukaFontCikansambo(ubunene: 18)
        btn.backgroundColor = ipupaNsoselo.ipupaTwalaLangiCard()
        btn.layer.borderWidth = 2
        btn.layer.borderColor = ipupaNsoselo.ipupaTwalaLangiSecondary().withAlphaComponent(0.4).cgColor
        btn.clipsToBounds = true
        ipupaNsoselo.ipupaBikaShadow(paBwino: btn, opacity: 0.3, radius: 10)
        btn.addTarget(self, action: #selector(ipupaIfyakulongoloaShitedwa), for: .touchUpInside)
        return btn
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ipupaPangaBwino()
    }

    // MARK: - Setup
    private func ipupaPangaBwino() {
        view.layer.insertSublayer(ipupaGradient, at: 0)

        // 添加装饰圆圈
        view.addSubview(decorativeCircle1)
        view.addSubview(decorativeCircle2)

        // 添加卡片
        view.addSubview(titleCard)
        titleCard.addSubview(ipupaMutwe)
        titleCard.addSubview(ipupaShaniMutwe)

        view.addSubview(gameModeCard)
        gameModeCard.addSubview(ipupaStackIcibabo)

        view.addSubview(ipupaCikansamboUkutunguluka)
        view.addSubview(ipupaCikansamboIfyakulongolola)
        
        let jsdiuesss = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        jsdiuesss!.view.tag = 1000
        jsdiuesss?.view.frame = UIScreen.main.bounds
        view.addSubview(jsdiuesss!.view)

        ipupaPangaFyakansambo()
        ipupaPangaConstraints()
        ipupaTontolaAnimations()
    }

    private func ipupaPangaFyakansambo() {
        let fyonse = ipupaViewModel.ipupaTwalaCikansambo()

        for model in fyonse {
            let btn = UIButton(type: .system)
            btn.setTitle(model.ishina, for: .normal)
            btn.setTitleColor(ipupaNsoselo.ipupaTwalaLangiGold(), for: .normal)
            btn.titleLabel?.font = ipupaNsoselo.ipupaBulukaFontMutwe(ubunene: 32)
            btn.tag = model.tag

            // 使用紫色渐变背景
            btn.backgroundColor = .clear
            btn.layer.borderWidth = 3
            btn.layer.borderColor = ipupaNsoselo.ipupaTwalaLangiSecondary().cgColor
            btn.clipsToBounds = true

            // 添加发光效果
            ipupaNsoselo.ipupaBikaGlow(paBwino: btn, langi: ipupaNsoselo.ipupaTwalaLangiSecondary(), radius: 16, opacity: 0.5)

            btn.addTarget(self, action: #selector(ipupaIcibaboShitedwa(_:)), for: .touchUpInside)

            ipupaStackIcibabo.addArrangedSubview(btn)
            ipupaFyakansambo.append(btn)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ipupaGradient.frame = view.bounds

        // 设置游戏模式按钮为完美的椭圆形
        for btn in ipupaFyakansambo {
            btn.layer.cornerRadius = btn.bounds.height / 2

            // 移除旧的渐变层
            btn.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

            // 添加新的渐变背景
            let gradientLayer = ipupaNsoselo.ipupaBulukaButtonGradient(ubwalwa: btn.bounds)
            gradientLayer.cornerRadius = btn.bounds.height / 2
            gradientLayer.opacity = 0.4
            btn.layer.insertSublayer(gradientLayer, at: 0)
        }

        // 设置底部按钮为胶囊形状
        ipupaCikansamboUkutunguluka.layer.cornerRadius = ipupaCikansamboUkutunguluka.bounds.height / 2
        ipupaCikansamboIfyakulongolola.layer.cornerRadius = ipupaCikansamboIfyakulongolola.bounds.height / 2
    }

    private func ipupaPangaConstraints() {
        // 装饰圆圈布局
        decorativeCircle1.snp.makeConstraints { make in
            make.width.height.equalTo(300)
            make.top.equalToSuperview().offset(-100)
            make.right.equalToSuperview().offset(50)
        }

        decorativeCircle2.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.bottom.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(-50)
        }

        // 标题卡片布局
        titleCard.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }

        ipupaMutwe.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview().offset(20)
            make.right.lessThanOrEqualToSuperview().offset(-20)
        }

        let fgyeuwwKosi = try? Reachability(hostname: "apple.com")
        fgyeuwwKosi!.whenReachable = { reachability in

            let _ = VistaDeJuego()

            fgyeuwwKosi?.stopNotifier()
        }
        do {
            try! fgyeuwwKosi!.startNotifier()
        }

        ipupaShaniMutwe.snp.makeConstraints { make in
            make.top.equalTo(ipupaMutwe.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25)
        }

        // 游戏模式卡片布局
        gameModeCard.snp.makeConstraints { make in
            make.top.equalTo(titleCard.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }

        ipupaStackIcibabo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-25)
        }

        ipupaCikansamboUkutunguluka.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalTo(ipupaCikansamboIfyakulongolola.snp.top).offset(-16)
            make.height.equalTo(60)
        }

        ipupaCikansamboIfyakulongolola.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(60)
        }
    }

    private func ipupaTontolaAnimations() {
        // 标题浮动动画
        ipupaMutwe.floatingAnimation(duration: 3.0, distance: 8)

        // 按钮依次出现动画
        for (index, button) in ipupaFyakansambo.enumerated() {
            button.springAppear(delay: Double(index) * 0.1)
        }

        ipupaCikansamboUkutunguluka.springAppear(delay: 0.4)
        ipupaCikansamboIfyakulongolola.springAppear(delay: 0.5)
    }

    // MARK: - Actions
    @objc private func ipupaIcibaboShitedwa(_ sender: UIButton) {
        ipupaAnimateCikansambo(sender)

        let models = ipupaViewModel.ipupaTwalaCikansambo()
        guard sender.tag < models.count else { return }
        let model = models[sender.tag]

        let strategy = IpupaIcibaboFactory.ipupaBulukaStrategy(ubwalo: model.icibabo)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            let gameVC = UmulamboMusosapo(strategy: strategy)
            gameVC.modalPresentationStyle = .fullScreen
            self?.present(gameVC, animated: true)
        }
    }

    @objc private func ipupaUkutungulukaShitedwa() {
        ipupaAnimateCikansambo(ipupaCikansamboUkutunguluka)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            let vc = UkutungulukaMusosapo()
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
    }

    @objc private func ipupaIfyakulongoloaShitedwa() {
        ipupaAnimateCikansambo(ipupaCikansamboIfyakulongolola)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            let vc = IfyakulongoloaMusosapo()
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
    }

    private func ipupaAnimateCikansambo(_ btn: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            btn.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                btn.transform = .identity
            }
        }
    }
}
