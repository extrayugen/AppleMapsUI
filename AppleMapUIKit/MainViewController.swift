//
//  ViewController.swift
//  AppleMapUIKit
//
//  Created by Djallil Elkebir on 2023-01-07.
//

import UIKit
import MapKit
import Combine

class MainViewController: UIViewController {
    
    // MARK: - Components
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = viewModel
        
        return view
    }()
    
    private lazy var vButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        
        return stack
    }()
    
    private lazy var hButtonStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    private lazy var button3D: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "view.3d"), for: .normal)
        button.backgroundColor = .gray
        button.imageView?.tintColor = .white
        button.addTarget(self, action: #selector(didTap3DButton(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    private lazy var streetViewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "binoculars.fill"), for: .normal)
        button.backgroundColor = .gray
        button.imageView?.tintColor = .white
        button.addTarget(self, action: #selector(didTap3DButton(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 8
        
        return button
    }()
    
    private lazy var otherMapButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "map.fill"), for: .normal)
        button.backgroundColor = .gray
        button.imageView?.tintColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTap3DButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var mapButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "map.fill"), for: .normal)
        button.backgroundColor = .gray
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        button.layer.cornerRadius = 6
        button.imageView?.tintColor = .white
        button.addTarget(self, action: #selector(didTap3DButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.backgroundColor = .gray
        button.imageView?.tintColor = .white
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(didTap3DButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var bottomSheetController = BottomSheetViewController(viewModel: .init())
    
    // MARK: - Stored Properties

    private let viewModel: MainViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    private var bottomButtonAnchor: NSLayoutConstraint?
    
    // MARK: - Life Cycle

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        configureMapView()
        configureVButtons()
        configureHButtons()
        setObservers()
        // show BottomSheet
        navigationController?.present(bottomSheetController, animated: true)
    }
}

// MARK: - UI

extension MainViewController {
    private func setupStyle() {
        view.backgroundColor = .red
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureVButtons() {
        view.addSubview(vButtonStack)
        
        NSLayoutConstraint.activate([
            vButtonStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            vButtonStack.widthAnchor.constraint(equalToConstant: 60),
            vButtonStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vButtonStack.bottomAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor)
        ])
        
        vButtonStack.addArrangedSubviews([
            mapButton,
            locationButton,
            button3D
        ])
        
        NSLayoutConstraint.activate([
            mapButton.heightAnchor.constraint(equalToConstant: 45),
            mapButton.widthAnchor.constraint(equalToConstant: 45),

            locationButton.heightAnchor.constraint(equalToConstant: 45),
            locationButton.widthAnchor.constraint(equalToConstant: 45),
            
            button3D.heightAnchor.constraint(equalToConstant: 45),
            button3D.widthAnchor.constraint(equalToConstant: 45),
        ])
        
        vButtonStack.setCustomSpacing(30, after: locationButton)
    }
    
    private func configureHButtons() {
        view.addSubview(hButtonStack)
        
        NSLayoutConstraint.activate([
            hButtonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            hButtonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            hButtonStack.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        hButtonStack.addArrangedSubviews([
            streetViewButton,
            otherMapButton
        ])
        
        NSLayoutConstraint.activate([
            otherMapButton.heightAnchor.constraint(equalToConstant: 45),
            otherMapButton.widthAnchor.constraint(equalToConstant: 45),
            
            streetViewButton.heightAnchor.constraint(equalToConstant: 45),
            streetViewButton.widthAnchor.constraint(equalToConstant: 45)
        ])
        
        bottomButtonAnchor = hButtonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        bottomButtonAnchor?.isActive = true
    }
    
    private func animateBottomSheetTopButton(height: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.bottomButtonAnchor?.isActive = false
            self.bottomButtonAnchor = self.hButtonStack.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -height)
            self.bottomButtonAnchor?.isActive = true
            if height > self.view.frame.height - 80 {
                self.hButtonStack.isHidden = true
            } else {
                self.hButtonStack.isHidden = false
            }
        }
    }
}

// MARK: - Action(s)
extension MainViewController {
    @objc private func didTap3DButton(_ sender: UIButton) {
        
    }
}

// MARK: - BindViewModel

extension MainViewController {
    private func bindViewModel() {
        viewModel.$region
            .receive(on: DispatchQueue.main)
            .sink { [weak self] region in
                self?.mapView.region = region
            }.store(in: &subscriptions)
    }
}

// MARK: - Obervers

extension MainViewController {
    private func setObservers() {
        NotificationCenter.default.publisher(for: .bottomSheetHeight)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] notificationObject in
                guard let self = self, let height = notificationObject.object as? CGFloat, self.view.subviews.contains(self.hButtonStack) else { return }
                self.animateBottomSheetTopButton(height: height)
            }.store(in: &subscriptions)
    }
}
