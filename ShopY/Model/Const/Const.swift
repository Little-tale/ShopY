//
//  Const.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/23/24.
//

import Foundation


enum Const {
    
    enum NaverAPi {
        static let display = 30
    }
    
    enum AppText {
        static let appName = "ShopY"
        static let appIntroduce = "심플하게 쇼핑하자"
        static let profileRegMent = "프로필을 등록해 주세요"
        static let profileModifyMent = "프로필 수정 하기"
        static let profileHead = "NAME *"
        static let nameInfoMent = "이름을 입력해 주세요 (필수)"
        
        static let nameUnValid = "이름 형식이 맞지 않아요..."
        
        static let introduceHead = "Read Me"
        static let introduceMent = "자기소개를 작성해 주세요"
        
        static let phoneNumberHead = "Phone Number"
        static let phoneNumberInfoMent = "전화번호를 입력해주세요"
        static let PhoneNumberUnValid = "전화번호 양삭이 맞지 않아요 ( - 없이 )"
        
        static let saveMent = "저장"
        
        static let regSuccess = "등록 성공!"
        static let checkMent = "확인"
        
        static let modifySuccess = "수정 성공!"
    }
    static let appLogo = "ShopyLogo"
    
    enum RankingSection: String, CaseIterable {
        
        // 검색 문자
        case shoes = "신발"
        case clothes = "옷"
        case office = "사무용품"
        
        // 헤더 타이틀
        var headerTitle: String {
             return switch self {
             case .shoes:
                 "Shoes Rank"
             case .clothes:
                 "Clothing Rank"
             case .office:
                 "Office Supplies"
             }
        }
        
        var imageName: String {
            return switch self {
            case .shoes:
                "Shose"
            case .clothes:
                "Shirts"
            case .office:
                "Items"
            }
        }
    }
    
    
    enum RankingToBanner {
        static let appleSale = "Apple"
        static let headerText = "애플 특가전"
        static let appleImageName = "AppleLogo"
    }
    
    static let searchImage = "magnifyingglass"
    static let searchMent = "상품을 검색해 보세요"
}
