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
          return nil
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
        configureSelectedBackground()
        configureCell() 
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
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            forecastImage.rightAnchor.constraint(equalTo: currentTemperature.leftAnchor, constant: -40),
            forecastImage.widthAnchor.constraint(equalToConstant: 40),
            forecastImage.heightAnchor.constraint(equalToConstant: 20),
            currentTemperature.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        locationLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        currentTemperature.setContentCompressionResistancePriority(.defaultLow, for: .horizontal) 
    }
    
    func setupstackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 40
        stackView.backgroundColor = #colorLiteral(red: 0.4875565171, green: 0.658501327, blue: 0.8347119689, alpha: 1)
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
    
    func configureSelectedBackground() {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = #colorLiteral(red: 0.4875565171, green: 0.658501327, blue: 0.8347119689, alpha: 1)
        self.selectedBackgroundView = selectedBackgroundView
    }
    
    func configureCell() {
        backgroundColor = .clear
        layer.cornerRadius = 24
        clipsToBounds = true
    }
}
