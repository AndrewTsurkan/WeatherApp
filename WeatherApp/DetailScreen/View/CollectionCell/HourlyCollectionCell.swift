import UIKit

final class HourlyCollectionCell: UICollectionViewCell {
    
    static var identifier: String {
         return String(describing: self)
     }
    
    //MARK: - Private properties -
    private let dayLabel = UILabel()
    private let image = UIImageView()
    private let temp = UILabel()
    private let stackView = UIStackView()
    
    //MARK: - life cycle -
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayLabel.text = nil
        temp.text = nil
        image.image = nil
    }
}

//MARK: - Public -
extension HourlyCollectionCell {
    func configure(data: CellData) {
        dayLabel.text = data.time
        image.image = data.image
        temp.text = "\(data.temp)°"
    }
}

//MARK: - UI -
private extension HourlyCollectionCell {
    func setupUI() {
        addSubviews()
        makeConstraint()
        setupStackView()
        setupDayLabel()
        setupTemperature()
        setupImage()
    }
    
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(dayLabel)
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(temp)
    }
    
    func makeConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 3
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.backgroundColor = #colorLiteral(red: 0.4875565171, green: 0.658501327, blue: 0.8347119689, alpha: 1)
        stackView.distribution = .equalSpacing
    }
    
    func setupDayLabel() {
        dayLabel.textColor = .white
        dayLabel.textAlignment = .center
        dayLabel.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    func setupTemperature() {
        temp.textColor = .white
        temp.textAlignment = .center
        temp.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    func setupImage() {
        image.clipsToBounds = true
    }
    
    func configureCell() {
        backgroundColor = .clear
        clipsToBounds = true
    }
}

