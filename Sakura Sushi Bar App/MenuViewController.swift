//
//  testPageContr.swift
//  Sakura Sushi Bar App
//
//  Created by Josh Jarvis on 08/01/2024.
//

import UIKit
import CoreData

class MenuViewController: UIViewController {
    var menuResult: [MenuType] = []

    var scrollView: UIScrollView!
    var contentView: UIView!
    var stackView: UIStackView!
    var headingView: UIView!
    var headingLabel: UILabel!
    var headingImage: UIImageView!
    
    let coreDataManager = CoreDataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        // Call findMenuItems with a completion handler
        findMenuItems { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                // Handle the fetched data
                self.menuResult = result
                
                // Once findMenuItems is completed, proceed with setting up the scrollView and contentView
                self.layoutScrollViewAndContentView()

                self.stackView.axis = .vertical

                for menuItem in self.menuResult {
                    let cardView = CardView()
                    cardView.configure(with: menuItem.name, description: menuItem.desc, image: UIImage(named: menuItem.image))
                    self.stackView.addArrangedSubview(cardView)

                    // Add a vertical space between card views
                    self.stackView.setCustomSpacing(20, after: cardView)
                }
                
                self.scrollView.delegate = self
            }
            
        }
    }
    private func layoutScrollViewAndContentView() {
        
        scrollView = UIScrollView()
        contentView = UIView()
        stackView = UIStackView()
        headingView = UIView()
        headingLabel = UILabel()
        headingImage = UIImageView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        headingView.translatesAutoresizingMaskIntoConstraints = false
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        headingImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(headingView)
        headingView.addSubview(headingLabel)
        headingView.addSubview(headingImage)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            headingView.topAnchor.constraint(equalTo: view.topAnchor),
            headingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headingView.heightAnchor.constraint(equalToConstant: 233),
            
            headingImage.centerXAnchor.constraint(equalTo: headingView.centerXAnchor),
            headingImage.centerYAnchor.constraint(equalTo: headingView.centerYAnchor),
            headingImage.heightAnchor.constraint(equalToConstant: 75),
            headingImage.widthAnchor.constraint(equalToConstant: 60),
            
            headingLabel.topAnchor.constraint(equalTo: headingImage.bottomAnchor, constant: 8.0),
            headingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            scrollView.topAnchor.constraint(equalTo: headingView.bottomAnchor, constant: 1),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        headingView.backgroundColor = UIColor(red: 0.11, green: 0.10, blue: 0.10, alpha: 1.00)
        
        headingView.layer.cornerRadius = 5
        
        headingImage.contentMode = .scaleAspectFit
        headingImage.clipsToBounds = true
        headingImage.image = UIImage(named: "logo-no-text.png")
        // 60x75
        print("Image set: \(headingImage.image != nil)")

        headingLabel.text = "MENU"
        headingLabel.font = UIFont(name: "SixCaps", size: 24)
        headingLabel.font = headingLabel.font.withSize(48)
        headingLabel.textColor = .white
        headingLabel.textAlignment = .center
        headingLabel.adjustsFontSizeToFitWidth = true
        headingLabel.minimumScaleFactor = 2
        headingLabel.numberOfLines = 1
        
        view.backgroundColor = UIColor(red: 0.23, green: 0.20, blue: 0.20, alpha: 1.00)
        scrollView.backgroundColor = UIColor(red: 0.11, green: 0.10, blue: 0.10, alpha: 1.00)
        contentView.backgroundColor = UIColor(red: 0.11, green: 0.10, blue: 0.10, alpha: 1.00)
    }
}

extension MenuViewController: UIScrollViewDelegate {
    // Implement scrollViewDidScroll and other delegate methods here
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        for i in 0..<stackView.arrangedSubviews.count {
            let baseOffset = self.stackView.arrangedSubviews[i].frame.maxY - 60
            
            if (scrollView.contentOffset.y >= baseOffset) {
                UIView.animate(withDuration: 0.75, delay: 0, options: [], animations: {
                    self.stackView.arrangedSubviews[i].transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                          })
            }
            
            if (scrollView.contentOffset.y < baseOffset) {
                UIView.animate(withDuration: 0.75, delay: 0, options: [], animations: {
                    self.stackView.arrangedSubviews[i].transform = CGAffineTransform(scaleX: 1, y: 1)
                          })
            }
        }
    }
}



class CardView: UIView {
    let coreDataManager = CoreDataManager.shared
    private let containerView: UIView = {
            let view = UIView()
            return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SixCaps", size: 18)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SixCaps", size: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
//    private let addToBasketButton: UIButton = {
//        let addButton = UIButton(type: .system)
//        addButton.setTitle("Add to Basket", for: .normal)
//        return addButton
//    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(cardImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 16

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),

            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 140),
            containerView.widthAnchor.constraint(equalToConstant: 370),
            
  
            cardImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            cardImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            cardImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            cardImageView.widthAnchor.constraint(equalToConstant: 150),
            
            titleLabel.leadingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),

            descriptionLabel.leadingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding)
        ])
        
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.backgroundColor = UIColor(red: 0.95, green: 0.87, blue: 0.87, alpha: 1.00)
        containerView.clipsToBounds = true
        
        titleLabel.textColor = .black
        
        descriptionLabel.textColor = .black
    }

    func configure(with title: String, description: String, image: UIImage?) {
        titleLabel.text = title
        descriptionLabel.text = description
        cardImageView.image = image
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addItemButtonTapped))
        containerView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Button tap action
    @objc func addItemButtonTapped() {
        // Add an item to the basket when the button is tapped
        coreDataManager.addItemToBasket(name: titleLabel.text ?? "Lemon", price: 3.99)
        let res = coreDataManager.fetchAllBaskets()
        coreDataManager.saveContext()
    }
}
