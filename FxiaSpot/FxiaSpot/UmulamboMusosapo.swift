//
//  UmulamboMusosapo.swift
//  FxiaSpot
//
//  Refactored with presenter pattern and delegate
//

import UIKit
import SnapKit

// Presenter protocol
protocol IpupaUmulamboPresenter {
    func ipupaTontolaUpya()
    func ipupaCipandeShitedwa(pa: Int)
    func ipupaPitya()
}

// Game view controller with presenter
class UmulamboMusosapo: UIViewController {
    private let ipupaStrategy: IpupaIcibaboStrategy
    private var ipupaAmano: AmanoUmulamboMupangapo!
    private var ipupaUkuba: UkubaUmulamboMupangapo!
    private var ipupaFyabwino: [CipandeBwinoPangapo] = []
    private var ipupaFyacipande: [CipandeMutamboAkalango] = []

    private let ipupaNsoselo = NsoseloUmulamboMupangapo.ipupaShared
    private lazy var ipupaGradient = ipupaNsoselo.ipupaBulukaGradient(ubwalwa: .zero)

    // UI
    private lazy var ipupaMutweView: UIView = {
        let v = UIView()
        v.backgroundColor = ipupaNsoselo.ipupaTwalaLangiCard()
        ipupaNsoselo.ipupaBikaShadow(paBwino: v, opacity: 0.3, radius: 8)
        return v
    }()

    private lazy var ipupaCikansamPitya: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("✕", for: .normal)
        b.setTitleColor(ipupaNsoselo.ipupaTwalaLangiText(), for: .normal)
        b.titleLabel?.font = ipupaNsoselo.ipupaBulukaFontMutwe(ubunene: 28)
        b.addTarget(self, action: #selector(ipupaPityedwa), for: .touchUpInside)
        return b
    }()

    private lazy var ipupaItondoIfyalulwa: UILabel = {
        let l = UILabel()
        l.text = "Score: 0"
        l.font = ipupaNsoselo.ipupaBulukaFontMutwe(ubunene: 22)
        l.textColor = ipupaNsoselo.ipupaTwalaLangiGold()
        l.textAlignment = .center
        return l
    }()

    private lazy var ipupaItondoUkupitilizya: UILabel = {
        let l = UILabel()
        l.text = ""
        l.font = ipupaNsoselo.ipupaBulukaFontCikansambo(ubunene: 16)
        l.textColor = ipupaNsoselo.ipupaTwalaLangiAccent()
        l.textAlignment = .center
        l.alpha = 0
        return l
    }()

    private lazy var ipupaAkatambo: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()

    private lazy var ipupaItondoKambi: UILabel = {
        let l = UILabel()
        l.text = "Find tiles that are NOT the majority type!\n⚠️ One wrong tap = Game Over!"
        l.font = ipupaNsoselo.ipupaBulukaFontUmubili(ubunene: 14)
        l.textColor = ipupaNsoselo.ipupaTwalaLangiTextSecondary()
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()

    private lazy var ipupaCikansamboUpya: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("New Round", for: .normal)
        b.ipupaBikaStyleSecondary()
        b.addTarget(self, action: #selector(ipupaUpyaShitedwa), for: .touchUpInside)
        return b
    }()

    init(strategy: IpupaIcibaboStrategy) {
        self.ipupaStrategy = strategy
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ipupaTontolaUmulambo()
        ipupaPangaBwino()
        ipupaTontolaUmuzunguluko()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ipupaGradient.frame = view.bounds
    }

    private func ipupaTontolaUmulambo() {
        ipupaAmano = AmanoUmulamboMupangapo(strategy: ipupaStrategy)
        ipupaUkuba = UkubaUmulamboMupangapo(strategy: ipupaStrategy)
    }

    private func ipupaPangaBwino() {
        view.layer.insertSublayer(ipupaGradient, at: 0)

        view.addSubview(ipupaMutweView)
        ipupaMutweView.addSubview(ipupaCikansamPitya)
        ipupaMutweView.addSubview(ipupaItondoIfyalulwa)
        ipupaMutweView.addSubview(ipupaItondoUkupitilizya)
        view.addSubview(ipupaAkatambo)
        view.addSubview(ipupaItondoKambi)
        view.addSubview(ipupaCikansamboUpya)

        ipupaPangaConstraints()
    }

    private func ipupaPangaConstraints() {
        ipupaMutweView.snp.makeConstraints { $0.top.left.right.equalToSuperview(); $0.height.equalTo(140) }
        ipupaCikansamPitya.snp.makeConstraints { $0.top.equalTo(view.safeAreaLayoutGuide).offset(10); $0.left.equalToSuperview().offset(20); $0.width.height.equalTo(44) }
        ipupaItondoIfyalulwa.snp.makeConstraints { $0.top.equalTo(view.safeAreaLayoutGuide).offset(20); $0.centerX.equalToSuperview() }
        ipupaItondoUkupitilizya.snp.makeConstraints { $0.top.equalTo(ipupaItondoIfyalulwa.snp.bottom).offset(8); $0.centerX.equalToSuperview() }
        ipupaAkatambo.snp.makeConstraints { $0.center.equalToSuperview(); $0.width.height.equalTo(ipupaBalaUbuneneAkatambo()) }
        ipupaItondoKambi.snp.makeConstraints { $0.bottom.equalTo(ipupaCikansamboUpya.snp.top).offset(-20); $0.left.equalToSuperview().offset(30); $0.right.equalToSuperview().offset(-30) }
        ipupaCikansamboUpya.snp.makeConstraints { $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20); $0.left.equalToSuperview().offset(40); $0.right.equalToSuperview().offset(-40); $0.height.equalTo(50) }
    }

    private func ipupaBalaUbuneneAkatambo() -> CGFloat {
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        return min(w - 60, h - 300)
    }

    private func ipupaTontolaUmuzunguluko() {
        ipupaFyacipande = ipupaAmano.ipupaBulukaCipande()
        ipupaPangaAkatambo()
        for (i, c) in ipupaFyacipande.enumerated() {
            ipupaFyabwino[i].ipupaBika(cipande: c) { [weak self] in self?.ipupaCipandeShitedwa(pa: i) }
        }
        ipupaBumbaItondo()
    }

    private func ipupaPangaAkatambo() {
        ipupaFyabwino.forEach { $0.removeFromSuperview() }
        ipupaFyabwino.removeAll()

        let ubunene = ipupaStrategy.ipupaUbuneneAkatambo
        let spacing: CGFloat = 8
        let containerSize = ipupaBalaUbuneneAkatambo()
        let tileSize = (containerSize - CGFloat(ubunene - 1) * spacing) / CGFloat(ubunene)

        for row in 0..<ubunene {
            for col in 0..<ubunene {
                let v = CipandeBwinoPangapo()
                ipupaAkatambo.addSubview(v)
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(CGFloat(col) * (tileSize + spacing))
                    make.top.equalToSuperview().offset(CGFloat(row) * (tileSize + spacing))
                    make.width.height.equalTo(tileSize)
                }
                ipupaFyabwino.append(v)

                v.alpha = 0
                v.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                UIView.animate(withDuration: 0.4, delay: Double(row * ubunene + col) * 0.03, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                    v.alpha = 1; v.transform = .identity
                })
            }
        }
    }

    @objc private func ipupaCipandeShitedwa(pa index: Int) {
        guard index < ipupaFyacipande.count else { return }
        let c = ipupaFyacipande[index]
        let v = ipupaFyabwino[index]

        // Skip if already processed

        let lyashi = ipupaAmano.ipupaLingulaShani(c)
        if lyashi {
            v.ipupaBumbaUkuba(ukuba: .ipupaLyashi)
            ipupaAmano.ipupaCipyaShani(c)
            if ipupaAmano.ipupaLingulaMalilwa() { ipupaMalilaUmuzunguluko(lyashi: true) }
        } else {
            v.ipupaBumbaUkuba(ukuba: .ipupaCisa)
            ipupaMalilaUmuzunguluko(lyashi: false)
        }
    }

    private func ipupaMalilaUmuzunguluko(lyashi: Bool) {
        if lyashi {
            let ifyalulwa = ipupaUkuba.ipupaMalilaUmuzunguluko(lyashi: true)
            ipupaSongesha(ifyalulwa: ifyalulwa)
            ipupaBulukaIfyacinso()
            ipupaBumbaItondo()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in self?.ipupaTontolaUmuzunguluko() }
        } else {
            ipupaSongeshaUmulamboMalilwa()
            if ipupaUkuba.ipupaTwalaIfyalulwaNomba() > 0 {
                UkutungulukaMupangapo.ipupaShared.ipupaSungaIfyalulwa(ipupaUkuba.ipupaTwalaIfyalulwaNomba(), paIcibabo: ipupaStrategy.ipupaTwalaIshina())
            }
            _ = ipupaUkuba.ipupaMalilaUmuzunguluko(lyashi: false)
            ipupaBumbaItondo()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in self?.ipupaTontolaUmuzunguluko() }
        }
    }

    private func ipupaBumbaItondo() {
        ipupaItondoIfyalulwa.text = "Score: \(ipupaUkuba.ipupaTwalaIfyalulwaNomba())"
        if ipupaUkuba.ipupaTwalaUkupitilizyaNomba() >= 3 {
            ipupaItondoUkupitilizya.text = "🔥 Combo x\(ipupaUkuba.ipupaTwalaUkupitilizyaNomba())"
            UIView.animate(withDuration: 0.3) { self.ipupaItondoUkupitilizya.alpha = 1 }
        } else {
            UIView.animate(withDuration: 0.3) { self.ipupaItondoUkupitilizya.alpha = 0 }
        }
    }

    private func ipupaSongesha(ifyalulwa: Int) {
        let l = UILabel()
        l.text = "+\(ifyalulwa)"
        l.font = ipupaNsoselo.ipupaBulukaFontMutwe(ubunene: 40)
        l.textColor = ipupaNsoselo.ipupaTwalaLangiGold()
        l.textAlignment = .center
        view.addSubview(l)
        l.snp.makeConstraints { $0.center.equalToSuperview() }
        l.alpha = 0
        l.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.5, animations: { l.alpha = 1; l.transform = .identity }) { _ in
            UIView.animate(withDuration: 0.3, delay: 0.5, animations: { l.alpha = 0 }) { _ in l.removeFromSuperview() }
        }
    }

    private func ipupaSongeshaUmulamboMalilwa() {
        let dim = UIView()
        dim.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        dim.alpha = 0
        view.addSubview(dim)
        dim.snp.makeConstraints { $0.edges.equalToSuperview() }

        let container = UIView()
        container.backgroundColor = ipupaNsoselo.ipupaTwalaLangiCard()
        container.layer.cornerRadius = 20
        view.addSubview(container)

        let mutwe = UILabel()
        mutwe.text = "GAME OVER"
        mutwe.font = ipupaNsoselo.ipupaBulukaFontMutwe(ubunene: 36)
        mutwe.textColor = ipupaNsoselo.ipupaTwalaLangiWrong()
        mutwe.textAlignment = .center

        let ifyalulwa = UILabel()
        ifyalulwa.text = "Final Score: \(ipupaUkuba.ipupaTwalaIfyalulwaNomba())"
        ifyalulwa.font = ipupaNsoselo.ipupaBulukaFontMutwe(ubunene: 24)
        ifyalulwa.textColor = ipupaNsoselo.ipupaTwalaLangiGold()
        ifyalulwa.textAlignment = .center

        let msg = UILabel()
        msg.text = ipupaUkuba.ipupaTwalaIfyalulwaNomba() > 0 ? "Nice try!\nYour score has been saved." : "Wrong on first try!\nStarting over..."
        msg.font = ipupaNsoselo.ipupaBulukaFontUmubili(ubunene: 16)
        msg.textColor = ipupaNsoselo.ipupaTwalaLangiTextSecondary()
        msg.textAlignment = .center
        msg.numberOfLines = 0

        container.addSubview(mutwe); container.addSubview(ifyalulwa); container.addSubview(msg)
        container.snp.makeConstraints { $0.center.equalToSuperview(); $0.left.equalToSuperview().offset(40); $0.right.equalToSuperview().offset(-40) }
        mutwe.snp.makeConstraints { $0.top.equalToSuperview().offset(30); $0.centerX.equalToSuperview() }
        ifyalulwa.snp.makeConstraints { $0.top.equalTo(mutwe.snp.bottom).offset(20); $0.centerX.equalToSuperview() }
        msg.snp.makeConstraints { $0.top.equalTo(ifyalulwa.snp.bottom).offset(15); $0.left.equalToSuperview().offset(20); $0.right.equalToSuperview().offset(-20); $0.bottom.equalToSuperview().offset(-30) }

        container.alpha = 0; container.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.3, animations: { dim.alpha = 1; container.alpha = 1; container.transform = .identity }) { _ in
            UIView.animate(withDuration: 0.3, delay: 1.3, animations: { dim.alpha = 0; container.alpha = 0 }) { _ in dim.removeFromSuperview(); container.removeFromSuperview() }
        }
    }

    private func ipupaBulukaIfyacinso() {
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
        emitter.emitterShape = .circle
        emitter.emitterSize = CGSize(width: 100, height: 100)
        let cell = CAEmitterCell()
        cell.birthRate = 50; cell.lifetime = 2.0; cell.velocity = 150; cell.emissionRange = .pi * 2; cell.scale = 0.1; cell.alphaSpeed = -0.5
        cell.contents = ipupaPangaCishinishi().cgImage; cell.color = ipupaNsoselo.ipupaTwalaLangiGold().cgColor
        emitter.emitterCells = [cell]
        view.layer.addSublayer(emitter)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { emitter.birthRate = 0 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { emitter.removeFromSuperlayer() }
    }

    private func ipupaPangaCishinishi() -> UIImage {
        let size = CGSize(width: 10, height: 10)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fillEllipse(in: CGRect(origin: .zero, size: size))
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return img
    }

    @objc private func ipupaPityedwa() {
        if ipupaUkuba.ipupaTwalaIfyalulwaNomba() > 0 {
            UkutungulukaMupangapo.ipupaShared.ipupaSungaIfyalulwa(ipupaUkuba.ipupaTwalaIfyalulwaNomba(), paIcibabo: ipupaStrategy.ipupaTwalaIshina())
        }
        dismiss(animated: true)
    }

    @objc private func ipupaUpyaShitedwa() {
        ipupaTontolaUmuzunguluko()
    }
}
