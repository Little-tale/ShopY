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
    
    private
    let currentButtonState = CurrentValueSubject<[Bool],Never> (.init(repeating: false, count: 2))
    
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

        var value = currentButtonState.value
        
        switch action {
        case .nameChange(let name):
            
            value[0] = !name.isEmpty
            currentButtonState.send(value)
            state.name = name
        case .introduce(let intro):
            
            state.introduce = intro
        case .phoneNumber(let number):
            if number.isEmpty {
                value[1] = true
            } else if number.count > 7 {
                value[1] = true
            } else {
                value[1] = false
            }
            state.phoneNumber = number
        case .userImage(let image):
            
            state.userImage = image
            
        case .saveProfile:
            break
        }
        
        currentButtonState
            .sink {[weak self] bools in
                self?.state.saveButtonState = bools.allSatisfy({ $0 == true })
            }
            .store(in: &cancellables)
    }
    
}
