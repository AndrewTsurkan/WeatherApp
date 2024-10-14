import Foundation

protocol DetailScreenView: AnyObject {
    func configure(data: ContentViewData)
    func reloadCollectioView()
}
