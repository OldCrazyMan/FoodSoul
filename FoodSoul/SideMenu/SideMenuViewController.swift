import UIKit

final class SideMenuViewController: UIViewController {
    
    private let johnImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sideMenu")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = Constants.Color.specialWhite
        view.addSubview(johnImageView)
    }
    
    private func setupConstraints() {        
            NSLayoutConstraint.activate([
                johnImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Constants.sideMenuAvatarLeading),
                johnImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                johnImageView.widthAnchor.constraint(equalToConstant: Constants.Constants.sideMenuAvatarWidthAnchor),
                johnImageView.heightAnchor.constraint(equalToConstant: Constants.Constants.sideMenuAvatarHeightAnchor)
            ])
        }
}
