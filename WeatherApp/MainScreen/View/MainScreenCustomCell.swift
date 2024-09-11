import UIKit

final class MainScreenCustomCell: UITableViewCell {
    
    static var identifier: String {
         return String(describing: self)
     }
    
    //MARK: -Private properties -
    let locationLabel = UILabel()
    let currentTemperature = UILabel()
    let forecastImage = UIImageView()
    let stackView = UIStackView()
    
    //MARK: - life cycle -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          setupUI()
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    override func prepareForReuse() {
        locationLabel.text = nil
        currentTemperature.text = nil
        forecastImage.image = nil
    }
}

//MARK: - Public -
extension MainScreenCustomCell {
    func configure() {
        
    }
}
//MARK: - UI -
private extension MainScreenCustomCell {
    func setupUI() {
        addSubviews()
        makeConstraint()
        setupstackView()
        setupLocationLabel()
        setupCurrentTemperature()
        setupForecastImage()
        backgroundColor = .clear
    }
    
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(forecastImage)
        stackView.addArrangedSubview(currentTemperature)
    }
    
    func makeConstraint() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupstackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 40
        stackView.backgroundColor = #colorLiteral(red: 0.4875565171, green: 0.658501327, blue: 0.8347119689, alpha: 1)
        stackView.layer.cornerRadius = 16
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
    }
    
    func setupLocationLabel() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.textAlignment = .left
        locationLabel.textColor = .label
    }
    
    func setupCurrentTemperature() {
        currentTemperature.translatesAutoresizingMaskIntoConstraints = false
        currentTemperature.textAlignment = .right
        currentTemperature.textColor = .label
    }
    
    func setupForecastImage() {
        forecastImage.translatesAutoresizingMaskIntoConstraints = false
        forecastImage.clipsToBounds = true
    }
    
}
