//
//  SignInViewModel.swift
//  10 Food
//
//  Created by Yevhen Biiak on 18.01.2023.
//

protocol SignInViewModel {
    var signInError: String? { get }
    var homeViewModel: HomeViewModel? { get }
    var onUpdate: ((SignInViewModel) -> Void)? { get set }
    func phoneChanged(phone: String?)
    func signInButtonTapped(phone: String, password: String)
    func signUpViewModel() -> SignUpViewModel
}

class SignInViewModelImpl: SignInViewModel {
    
    private let authService: AuthService
    private var phone: String?
    private var password: String?
    
    var signInError: String? {
        didSet { onUpdate?(self) }
    }
    var homeViewModel: HomeViewModel? {
        didSet { onUpdate?(self) }
    }
    var onUpdate: ((SignInViewModel) -> Void)? {
        didSet { onUpdate?(self) }
    }

    init(authService: AuthService) {
        self.authService = authService
        if let user = self.authService.currentUser() {
            initializeHomeViewModel(with: user)
        }
    }
    
    func phoneChanged(phone: String?) {
        self.phone = phone
    }
    
    func signInButtonTapped(phone: String, password: String) {
        do {
            let user = try authService.signIn(phone: phone, password: password)
            initializeHomeViewModel(with: user)
        } catch {
            signInError = error.localizedDescription
        }
    }
    
    func signUpViewModel() -> SignUpViewModel {
        SignUpViewModelImpl(authService: authService, phone: phone)
    }
    
    private func initializeHomeViewModel(with user: User) {
        homeViewModel = HomeViewModelImpl(user: user)
    }
}
