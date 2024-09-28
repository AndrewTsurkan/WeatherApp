import UIKit

final class DetailScreenContentView: UIView {
//MARK: - Private properties -
    private let currentLocationLabel = UILabel()
    private let currentTempLabel = UILabel()
    private let currentWeatherLabel = UILabel()
    private let hourlyCollectionView = UICollectionView()
    private let forecastTableView = UITableView()
}

//MARK: - UI -
private extension DetailScreenContentView {
    func setupUI() {
        addSubviews()
        makeConstraints()
        setupCurrentLocationLabel()
        setupCurrentTempLabel()
        setupcurrentWeatherLabel()
        setupCollectionView()
        setupTableView()
    }
    
    func addSubviews() {
        addSubview(currentLocationLabel)
        addSubview(currentTempLabel)
        addSubview(currentWeatherLabel)
        addSubview(hourlyCollectionView)
        addSubview(forecastTableView)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
        currentLocationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
        currentLocationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        
        currentTempLabel.topAnchor.constraint(equalTo: currentLocationLabel.bottomAnchor, constant: 10),
        currentTempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        
        currentWeatherLabel.topAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: 10),
        currentWeatherLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        
        hourlyCollectionView.topAnchor.constraint(equalTo: currentWeatherLabel.bottomAnchor, constant: 20),
        hourlyCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
        hourlyCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
    }
    
    func setupCurrentLocationLabel() {
        
    }
    
    func setupCurrentTempLabel() {
        
    }
    
    func setupcurrentWeatherLabel() {
        
    }
    
    func setupCollectionView() {
        
    }
    
    func setupTableView() {
        
    }
}
