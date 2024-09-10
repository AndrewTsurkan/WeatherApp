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
    }
    
    func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(forecastImage)
        stackView.addArrangedSubview(currentTemperature)
    }
    
    func makeConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            forecastImage.widthAnchor.constraint(equalToConstant: 30),
            forecastImage.heightAnchor.constraint(equalToConstant: 20)])
    }
    
    func setupstackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 40
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
