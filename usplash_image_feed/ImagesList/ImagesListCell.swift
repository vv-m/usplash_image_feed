import UIKit


final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var gradientView: UIView!
    
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        
        // Настраиваем цвета градиента
        let transparentColor = UIColor(red: 0.102, green: 0.106, blue: 0.133, alpha: 0.0) // #1A1B22 с 0% непрозрачности
        let solidColor = UIColor(red: 0.102, green: 0.106, blue: 0.133, alpha: 1.0) // #1A1B22 с 100% непрозрачности

        gradientLayer.colors = [
            transparentColor.cgColor,
            solidColor.cgColor
        ]
        // Задаем расположение точек остановки (0% и 100%)
        gradientLayer.locations = [0.0, 0.5]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        gradientView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        
        gradientView.alpha = 0.2
        
        let cornerRadius: CGFloat = 16
        gradientView.layer.cornerRadius = cornerRadius
        gradientView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] // только нижние углы скругляем
        gradientView.layer.masksToBounds = true
    }
}
