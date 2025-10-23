
import UIKit
import SnapKit

class LeastFindLeaderboardViewController: UIViewController {

    private let leastFindGradientLayer = LeastFindTheme.leastFindCreateGradientLayer(bounds: .zero)
    private var leastFindSelectedMode: XdsiduGameMode = .threeByThree

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
        label.text = "🏆 Leaderboard"
        label.font = LeastFindTheme.leastFindTitleFont(size: 28)
        label.textColor = LeastFindTheme.leastFindGoldTextColor
        label.textAlignment = .center
        return label
    }()

    private lazy var leastFindModeSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["3×3", "4×4", "5×5"])
        control.selectedSegmentIndex = 0
        control.backgroundColor = LeastFindTheme.leastFindCardBackgroundColor
        control.selectedSegmentTintColor = LeastFindTheme.leastFindSecondaryColor
        control.setTitleTextAttributes([.foregroundColor: LeastFindTheme.leastFindPrimaryTextColor, .font: LeastFindTheme.leastFindButtonFont(size: 14)], for: .normal)
        control.setTitleTextAttributes([.foregroundColor: LeastFindTheme.leastFindPrimaryColor, .font: LeastFindTheme.leastFindButtonFont(size: 14)], for: .selected)
        control.addTarget(self, action: #selector(leastFindModeChanged), for: .valueChanged)
        return control
    }()

    private lazy var leastFindTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LeastFindLeaderboardCell.self, forCellReuseIdentifier: "LeastFindLeaderboardCell")
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    private lazy var leastFindEmptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No scores yet.\nPlay some games to get on the board!"
        label.font = LeastFindTheme.leastFindBodyFont(size: 16)
        label.textColor = LeastFindTheme.leastFindSecondaryTextColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    private var leastFindScores: [LeastFindLeaderboardEntry] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        leastFindSetupUI()
        leastFindLoadScores()
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

        view.addSubview(leastFindModeSegmentedControl)
        view.addSubview(leastFindTableView)
        view.addSubview(leastFindEmptyLabel)

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

        leastFindModeSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(leastFindHeaderView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }

        leastFindTableView.snp.makeConstraints { make in
            make.top.equalTo(leastFindModeSegmentedControl.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        leastFindEmptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }
    }

    private func leastFindLoadScores() {
        leastFindScores = LeastFindLeaderboardManager.leastFindShared.leastFindGetTopScores(for: leastFindSelectedMode, limit: 50)
        leastFindTableView.reloadData()
        leastFindEmptyLabel.isHidden = !leastFindScores.isEmpty
    }

    // MARK: - Actions
    @objc private func leastFindBackButtonTapped() {
        dismiss(animated: true)
    }

    @objc private func leastFindModeChanged() {
        switch leastFindModeSegmentedControl.selectedSegmentIndex {
        case 0: leastFindSelectedMode = .threeByThree
        case 1: leastFindSelectedMode = .fourByFour
        case 2: leastFindSelectedMode = .fiveByFive
        default: break
        }
        leastFindLoadScores()
    }
}

// MARK: - UITableViewDataSource
extension LeastFindLeaderboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leastFindScores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeastFindLeaderboardCell", for: indexPath) as! LeastFindLeaderboardCell
        let entry = leastFindScores[indexPath.row]
        let rank = indexPath.row + 1
        cell.leastFindConfigure(rank: rank, score: entry.leastFindScore, date: entry.leastFindDate)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LeastFindLeaderboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - Leaderboard Cell
class LeastFindLeaderboardCell: UITableViewCell {

    private let leastFindContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = LeastFindTheme.leastFindCardBackgroundColor
        view.layer.cornerRadius = 12
        return view
    }()

    private let leastFindRankLabel: UILabel = {
        let label = UILabel()
        label.font = LeastFindTheme.leastFindTitleFont(size: 24)
        label.textAlignment = .center
        return label
    }()

    private let leastFindScoreLabel: UILabel = {
        let label = UILabel()
        label.font = LeastFindTheme.leastFindTitleFont(size: 20)
        label.textColor = LeastFindTheme.leastFindPrimaryTextColor
        return label
    }()

    private let leastFindDateLabel: UILabel = {
        let label = UILabel()
        label.font = LeastFindTheme.leastFindBodyFont(size: 12)
        label.textColor = LeastFindTheme.leastFindSecondaryTextColor
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        leastFindSetupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func leastFindSetupCell() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(leastFindContainerView)
        leastFindContainerView.addSubview(leastFindRankLabel)
        leastFindContainerView.addSubview(leastFindScoreLabel)
        leastFindContainerView.addSubview(leastFindDateLabel)

        leastFindContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        leastFindRankLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }

        leastFindScoreLabel.snp.makeConstraints { make in
            make.left.equalTo(leastFindRankLabel.snp.right).offset(15)
            make.top.equalToSuperview().offset(15)
        }

        leastFindDateLabel.snp.makeConstraints { make in
            make.left.equalTo(leastFindScoreLabel)
            make.top.equalTo(leastFindScoreLabel.snp.bottom).offset(5)
        }
    }

    func leastFindConfigure(rank: Int, score: Int, date: Date) {
        leastFindScoreLabel.text = "\(score) pts"

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        leastFindDateLabel.text = formatter.string(from: date)

        // Top 3 get special styling
        if rank == 1 {
            leastFindRankLabel.text = "🥇"
            leastFindContainerView.backgroundColor = UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 0.2)
            leastFindContainerView.layer.borderWidth = 2
            leastFindContainerView.layer.borderColor = LeastFindTheme.leastFindGoldTextColor.cgColor
        } else if rank == 2 {
            leastFindRankLabel.text = "🥈"
            leastFindContainerView.backgroundColor = UIColor(white: 0.75, alpha: 0.15)
            leastFindContainerView.layer.borderWidth = 2
            leastFindContainerView.layer.borderColor = UIColor(white: 0.75, alpha: 0.5).cgColor
        } else if rank == 3 {
            leastFindRankLabel.text = "🥉"
            leastFindContainerView.backgroundColor = UIColor(red: 0.8, green: 0.5, blue: 0.2, alpha: 0.15)
            leastFindContainerView.layer.borderWidth = 2
            leastFindContainerView.layer.borderColor = UIColor(red: 0.8, green: 0.5, blue: 0.2, alpha: 0.5).cgColor
        } else {
            leastFindRankLabel.text = "#\(rank)"
            leastFindRankLabel.textColor = LeastFindTheme.leastFindSecondaryTextColor
            leastFindContainerView.backgroundColor = LeastFindTheme.leastFindCardBackgroundColor
            leastFindContainerView.layer.borderWidth = 0
        }
    }
}
