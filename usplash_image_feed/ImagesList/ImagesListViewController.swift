import UIKit

class ImagesListViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "UsplashAppBlack") ?? .systemBlue
    }
}


extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        configCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier) as? ImagesListCell,
              let image = UIImage(named: photosName[indexPath.row]),
              image.size.width > 0 else {
            return 200
        }
        
        let verticalInsets = cell.topConstraint.constant + cell.bottomConstraint.constant
        let horizontalInsets = cell.trailingConstraint.constant + cell.leadingConstraint.constant
        
        let widthTableView = tableView.bounds.width - horizontalInsets
        let ratio = widthTableView / image.size.width
        
        let adaptiveHight = image.size.height * ratio + verticalInsets
        
        return adaptiveHight
    }
    
    
    private func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return
        }
        cell.cellImage.image = image
        cell.cellImage.layer.cornerRadius = 16
        cell.cellImage.layer.masksToBounds = true
        cell.backgroundColor = UIColor(named: "UsplashAppBlack") ?? .systemBlue
        cell.dataLabel.text = dateFormatter.string(from: Date())
        cell.selectionStyle = .none
        if indexPath.row % 2 == 0 {
            cell.likeButton.setImage(UIImage(named: "No Active"), for: .normal)
        } else {
            cell.likeButton.setImage(UIImage(named: "Active"), for: .normal)
        }
    }
}


extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
