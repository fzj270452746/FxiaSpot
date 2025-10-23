

import UIKit
import SnapKit

// State for tile view
enum IpupaCipandeUkuba {
    case ipupaNormal
    case ipupaSalula
    case ipupaLyashi
    case ipupaCisa

    func ipupaTwalaLangi(kwa nsoselo: NsoseloUmulamboMupangapo) -> UIColor {
        switch self {
        case .ipupaNormal: return .clear
        case .ipupaSalula: return nsoselo.ipupaTwalaLangiSelected()
        case .ipupaLyashi: return nsoselo.ipupaTwalaLangiCorrect()
        case .ipupaCisa: return nsoselo.ipupaTwalaLangiWrong()
        }
    }
}

// Animator protocol for different animations
protocol IpupaCipandeAnimator {
    func ipupaAnimate(paBwino view: UIView)
}

class IpupaShitaAnimator: IpupaCipandeAnimator {
    func ipupaAnimate(paBwino view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.5
        animation.values = [-10, 10, -10, 10, -5, 5, -2, 2, 0]
        view.layer.add(animation, forKey: "ipupaShita")
    }
}

class IpupaPopAnimator: IpupaCipandeAnimator {
    func ipupaAnimate(paBwino view: UIView) {
        UIView.animate(withDuration: 0.15, animations: {
            view.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }) { _ in
            UIView.animate(withDuration: 0.15) {
                view.transform = .identity
            }
        }
    }
}

// Composite view component
class CipandeBwinoPangapo: UIView {
    private var ipupaCipande: CipandeMutamboAkalango?
    private var ipupaUkuba: IpupaCipandeUkuba = .ipupaNormal {
        didSet { ipupaBumbaLango() }
    }

    private let ipupaNsoselo = NsoseloUmulamboMupangapo.ipupaShared
    private var ipupaShitaAction: (() -> Void)?

    // Subviews
    private let ipupaCishinishi: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()

    private let ipupaUmuzingo: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.clear.cgColor
        view.isUserInteractionEnabled = false
        return view
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        ipupaPanga()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    // MARK: - Setup
    private func ipupaPanga() {
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        layer.cornerRadius = 8
        ipupaNsoselo.ipupaBikaShadow(paBwino: self, opacity: 0.2, radius: 4, offset: CGSize(width: 0, height: 2))

        addSubview(ipupaCishinishi)
        addSubview(ipupaUmuzingo)

        ipupaCishinishi.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.85)
        }

        ipupaUmuzingo.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let gesture = UITapGestureRecognizer(target: self, action: #selector(ipupaShitedwa))
        addGestureRecognizer(gesture)
    }

    // MARK: - Configuration
    func ipupaBika(cipande: CipandeMutamboAkalango, shitaAction: @escaping () -> Void) {
        self.ipupaCipande = cipande
        self.ipupaShitaAction = shitaAction
        ipupaCishinishi.image = UIImage(named: cipande.ipupaTwalaIshina())
        ipupaUkuba = .ipupaNormal
    }

    func ipupaBumbaUkuba(ukuba: IpupaCipandeUkuba) {
        ipupaUkuba = ukuba
    }

    private func ipupaBumbaLango() {
        let langi = ipupaUkuba.ipupaTwalaLangi(kwa: ipupaNsoselo)

        UIView.animate(withDuration: 0.2) {
            self.ipupaUmuzingo.layer.borderColor = langi.cgColor

            switch self.ipupaUkuba {
            case .ipupaNormal:
                self.transform = .identity
            case .ipupaSalula:
                self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            case .ipupaLyashi, .ipupaCisa:
                self.transform = .identity
            }
        }

        // Trigger animations
        switch ipupaUkuba {
        case .ipupaCisa:
            IpupaShitaAnimator().ipupaAnimate(paBwino: self)
        case .ipupaLyashi:
            IpupaPopAnimator().ipupaAnimate(paBwino: self)
        default:
            break
        }
    }

    @objc private func ipupaShitedwa() {
        ipupaShitaAction?()
    }

    func ipupaBuyafyaUkuba() {
        ipupaUkuba = .ipupaNormal
    }
}
