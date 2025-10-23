

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
    private lazy var ipupaMutwe: UILabel = {
        let label = UILabel()
        label.text = ipupaViewModel.ipupaTwalaItondo()
        label.font = ipupaNsoselo.ipupaBulukaFontMutwe(ubunene: 38)
        label.textColor = ipupaNsoselo.ipupaTwalaLangiGold()
        label.textAlignment = .center
        label.numberOfLines = 0
        ipupaNsoselo.ipupaBikaShadow(paBwino: label, langi: .black, opacity: 0.5, radius: 10)
        return label
    }()

    private lazy var ipupaShaniMutwe: UILabel = {
        let label = UILabel()
        label.text = ipupaViewModel.ipupaTwalaSubtitle()
        label.font = ipupaNsoselo.ipupaBulukaFontUmubili(ubunene: 16)
        label.textColor = ipupaNsoselo.ipupaTwalaLangiSecondary()
        label.textAlignment = .center
        return label
    }()

    private lazy var ipupaStackIcibabo: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()

    private var ipupaFyakansambo: [UIButton] = []

    private lazy var ipupaCikansamboUkutunguluka: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("🏆 Leaderboard", for: .normal)
        btn.ipupaBikaStyleSecondary()
        btn.addTarget(self, action: #selector(ipupaUkutungulukaShitedwa), for: .touchUpInside)
        return btn
    }()

    private lazy var ipupaCikansamboIfyakulongolola: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("⚙️ Settings", for: .normal)
        btn.ipupaBikaStyleSecondary()
        btn.addTarget(self, action: #selector(ipupaIfyakulongoloaShitedwa), for: .touchUpInside)
        return btn
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ipupaPangaBwino()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ipupaGradient.frame = view.bounds
    }

    // MARK: - Setup
    private func ipupaPangaBwino() {
        view.layer.insertSublayer(ipupaGradient, at: 0)

        view.addSubview(ipupaMutwe)
        view.addSubview(ipupaShaniMutwe)
        view.addSubview(ipupaStackIcibabo)
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
            btn.ipupaBikaStyleIcibalo()
            btn.tag = model.tag
            btn.addTarget(self, action: #selector(ipupaIcibaboShitedwa(_:)), for: .touchUpInside)
            ipupaStackIcibabo.addArrangedSubview(btn)
            ipupaFyakansambo.append(btn)
        }
    }

    private func ipupaPangaConstraints() {
        ipupaMutwe.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
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
            make.top.equalTo(ipupaMutwe.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        ipupaStackIcibabo.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.lessThanOrEqualTo(400)
        }

        ipupaCikansamboUkutunguluka.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.bottom.equalTo(ipupaCikansamboIfyakulongolola.snp.top).offset(-15)
            make.height.equalTo(50)
        }

        ipupaCikansamboIfyakulongolola.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(50)
        }
    }

    private func ipupaTontolaAnimations() {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.duration = 2.0
        pulse.fromValue = 1.0
        pulse.toValue = 1.05
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        ipupaMutwe.layer.add(pulse, forKey: "ipupaPulse")
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
