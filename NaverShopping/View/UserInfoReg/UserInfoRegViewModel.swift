//
//  UserInfoRegViewModel.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import UIKit.UIImage
import Combine

final class UserInfoRegViewModel: MVIPatternType {
    
    private
    var cancellables: Set<AnyCancellable> = []
    
    @Published private(set)
    var state = StateModel()
    
    enum InputAction {
        case nameChange(String)
        case introduce(String)
        case phoneNumber(String)
        case userImage(UIImage)
        case saveProfile
    }
    
    struct StateModel {
        var name = ""
        var introduce = ""
        var phoneNumber = ""
        var userImage: UIImage? = nil
        var saveButtonState: Bool = false
    }
}

extension UserInfoRegViewModel {
    
    func send(_ action: InputAction) {
        
        let currentButtonState = CurrentValueSubject<[Bool],Never> (.init(repeating: false, count: 3))
        
        switch action {
        case .nameChange(let name):
            <#code#>
        case .introduce(let intro):
            <#code#>
        case .phoneNumber(let number):
            <#code#>
        case .userImage(let image):
            <#code#>
        case .saveProfile:
            <#code#>
        }
        
        currentButtonState
            .sink {[weak self] bools in
                self?.state.saveButtonState = bools.allSatisfy({ $0 == true })
            }
            .store(in: &cancellables)
    }
    
}
