//
//  UkutungulukaMusosapo.swift
//  FxiaSpot
//
//  Refactored with table view data source pattern
//

import UIKit
import SnapKit

class UkutungulukaMusosapo: UIViewController {
    private let ipupaNsoselo = NsoseloUmulamboMupangapo.ipupaShared
    private lazy var ipupaGradient = ipupaNsoselo.ipupaBulukaGradient(ubwalwa: .zero)
    private var ipupaIcibaboSalula: String = "3X3"
    private var ipupaFyalulwa: [IpupaIfyakulembaUkutunguluka] = []

    private lazy var ipupaMutweView: UIView = {
        let v = UIView()
        v.backgroundColor = ipupaNsoselo.ipupaTwalaLangiCard()
        ipupaNsoselo.ipupaBikaShadow(paBwino: v, opacity: 0.3, radius: 8)
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
        l.text = "🏆 Leaderboard"
        l.font = ipupaNsoselo.ipupaBulukaFontMutwe(ubunene: 28)
        l.textColor = ipupaNsoselo.ipupaTwalaLangiGold()
        l.textAlignment = .center
        return l
    }()

    private lazy var ipupaSegment: UISegmentedControl = {
        let s = UISegmentedControl(items: ["3×3", "4×4", "5×5"])
        s.selectedSegmentIndex = 0
        s.backgroundColor = ipupaNsoselo.ipupaTwalaLangiCard()
        s.selectedSegmentTintColor = ipupaNsoselo.ipupaTwalaLangiSecondary()
        s.addTarget(self, action: #selector(ipupaIcibaboBumbwa), for: .valueChanged)
        return s
    }()

    private lazy var ipupaTable: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
        t.backgroundColor = .clear
        t.separatorStyle = .none
        t.delegate = self
        t.dataSource = self
        t.register(IpupaCell.self, forCellReuseIdentifier: "cell")
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        ipupaPanga()
        ipupaTwalaFyalulwa()
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
        view.addSubview(ipupaSegment)
        view.addSubview(ipupaTable)

        ipupaMutweView.snp.makeConstraints { $0.top.left.right.equalToSuperview(); $0.height.equalTo(120) }
        ipupaCikansamBuyafye.snp.makeConstraints { $0.top.equalTo(view.safeAreaLayoutGuide).offset(10); $0.left.equalToSuperview().offset(20); $0.height.equalTo(44) }
        ipupaMutwe.snp.makeConstraints { $0.centerY.equalTo(ipupaCikansamBuyafye); $0.centerX.equalToSuperview() }
        ipupaSegment.snp.makeConstraints { $0.top.equalTo(ipupaMutweView.snp.bottom).offset(20); $0.left.equalToSuperview().offset(30); $0.right.equalToSuperview().offset(-30); $0.height.equalTo(40) }
        ipupaTable.snp.makeConstraints { $0.top.equalTo(ipupaSegment.snp.bottom).offset(20); $0.left.right.equalToSuperview(); $0.bottom.equalTo(view.safeAreaLayoutGuide) }
    }

    private func ipupaTwalaFyalulwa() {
        ipupaFyalulwa = UkutungulukaMupangapo.ipupaShared.ipupaTwalaYonseYapaIcibabo(ipupaIcibaboSalula)
        ipupaTable.reloadData()
    }

    @objc private func ipupaBuyafyedwa() {
        dismiss(animated: true)
    }

    @objc private func ipupaIcibaboBumbwa() {
        ipupaIcibaboSalula = ["3X3", "4X4", "5X5"][ipupaSegment.selectedSegmentIndex]
        ipupaTwalaFyalulwa()
    }
}

extension UkutungulukaMusosapo: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ipupaFyalulwa.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IpupaCell
        cell.ipupaBika(rank: indexPath.row + 1, ifya: ipupaFyalulwa[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

class IpupaCell: UITableViewCell {
    private let ipupaNsoselo = NsoseloUmulamboMupangapo.ipupaShared
    private let ipupaContainer = UIView()
    private let ipupaRank = UILabel()
    private let ipupaScore = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none

        ipupaContainer.backgroundColor = ipupaNsoselo.ipupaTwalaLangiCard()
        ipupaContainer.layer.cornerRadius = 12
        contentView.addSubview(ipupaContainer)
        ipupaContainer.addSubview(ipupaRank)
        ipupaContainer.addSubview(ipupaScore)

        ipupaContainer.snp.makeConstraints { $0.top.equalToSuperview().offset(5); $0.bottom.equalToSuperview().offset(-5); $0.left.equalToSuperview().offset(20); $0.right.equalToSuperview().offset(-20) }
        ipupaRank.snp.makeConstraints { $0.left.equalToSuperview().offset(15); $0.centerY.equalToSuperview(); $0.width.equalTo(50) }
        ipupaScore.snp.makeConstraints { $0.left.equalTo(ipupaRank.snp.right).offset(15); $0.centerY.equalToSuperview() }

        ipupaRank.font = ipupaNsoselo.ipupaBulukaFontMutwe(ubunene: 24)
        ipupaRank.textAlignment = .center
        ipupaScore.font = ipupaNsoselo.ipupaBulukaFontMutwe(ubunene: 20)
        ipupaScore.textColor = ipupaNsoselo.ipupaTwalaLangiText()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    func ipupaBika(rank: Int, ifya: IpupaIfyakulembaUkutunguluka) {
        ipupaScore.text = "\(ifya.ipupaIfyalulwa) pts"

        if rank == 1 {
            ipupaRank.text = "🥇"
            ipupaContainer.backgroundColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 0.2)
            ipupaContainer.layer.borderWidth = 2
            ipupaContainer.layer.borderColor = ipupaNsoselo.ipupaTwalaLangiGold().cgColor
        } else if rank == 2 {
            ipupaRank.text = "🥈"
            ipupaContainer.backgroundColor = UIColor(white: 0.75, alpha: 0.15)
            ipupaContainer.layer.borderWidth = 2
            ipupaContainer.layer.borderColor = UIColor(white: 0.75, alpha: 0.5).cgColor
        } else if rank == 3 {
            ipupaRank.text = "🥉"
            ipupaContainer.backgroundColor = UIColor(red: 0.8, green: 0.5, blue: 0.2, alpha: 0.15)
            ipupaContainer.layer.borderWidth = 2
            ipupaContainer.layer.borderColor = UIColor(red: 0.8, green: 0.5, blue: 0.2, alpha: 0.5).cgColor
        } else {
            ipupaRank.text = "#\(rank)"
            ipupaRank.textColor = ipupaNsoselo.ipupaTwalaLangiTextSecondary()
            ipupaContainer.backgroundColor = ipupaNsoselo.ipupaTwalaLangiCard()
            ipupaContainer.layer.borderWidth = 0
        }
    }
}
