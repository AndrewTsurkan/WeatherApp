import UIKit

final class HeaderSupplementaryView: UICollectionReusableView {
    //MARK: - Static properties -
    static var identifier: String {
         return String(describing: self)
     }
    //MARK: - Private properties -
    private let headerLabel = UILabel()
    private let separatorLine = UIView()
    
    //MARK: - Life cycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

//MARK: - Public -
extension HeaderSupplementaryView {
    func configure(headerText: String) {
        headerLabel.text = headerText
    }
}

//MARK: - Private -
private extension HeaderSupplementaryView {
    func setupUI() {
        addSubviews()
        makeConstraint()
        setupHeaderLabel()
        setupSeparatorLine()
    }
    
    func makeConstraint() {
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            separatorLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1),
            separatorLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func addSubviews() {
        addSubview(headerLabel)
        addSubview(separatorLine)
    }
    
    func setupHeaderLabel() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.systemFont(ofSize: 16)
        headerLabel.textAlignment = .left
        headerLabel.text = "Погода на 3 дня:"
        headerLabel.textColor = .white
        headerLabel.alpha = 0.8
    }
    
    func setupSeparatorLine() {
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.backgroundColor = .white
        separatorLine.alpha = 0.8
    }
}
