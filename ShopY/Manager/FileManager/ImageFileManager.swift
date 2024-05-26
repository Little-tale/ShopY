//
//  FileSingleToneManager.swift
//  NaverShopping
//
//  Created by Jae hyung Kim on 5/15/24.
//

import UIKit.UIImage

enum ImageFileManagerError: Error {
    case cantSaveImage
    case cantZip
    case directoryError
    case cantLoadImage
    case imageNotFound
    case cantRemoveImage
}

extension ImageFileManagerError: ErrorMessageType{
    var message: String {
        return switch self {
        case .cantSaveImage:
            "이미지 저장 실패"
        case .cantZip:
            "이미지 압축 실패"
        case .directoryError:
            "이미지 저장 실패"
        case .cantLoadImage:
            "이미지 로드 실패"
        case .imageNotFound:
            "이미지 불러오기 실패"
        case .cantRemoveImage:
            "이미지 삭제 실패"
        }
    }
}


final class ImageFileManager {

    static
    let shared = ImageFileManager()
    
    private
    init () {}
    
    private
    let fileManager = FileManager.default
    
    enum fileFolderPath {
        case profile
        
        case custom(custom: String)
        
        var path: String {
            return switch self {
            case .profile:
                "Profile"
            case .custom(let custom):
                 custom
            }
        }
    }
}

extension ImageFileManager {
    
    func saveImage(image: UIImage, folderPath: fileFolderPath, fileId: String) -> Result<URL, ImageFileManagerError>{
        
        guard let image = image.pngData() else {
            return .failure(.cantZip)
        }
        
        return saveImageData(
            pngData: image,
            folderPath: folderPath,
            fileId: fileId
        )
    }
    
    func saveImageData(pngData: Data, folderPath: fileFolderPath, fileId: String) -> Result<URL, ImageFileManagerError> {
        
        guard let directory = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else {
            return .failure(.cantSaveImage)
        }
        
        let folderUrl = directory.appendingPathComponent(folderPath.path, conformingTo: .directory)
        
        do {
            try fileManager.createDirectory(at: folderUrl, withIntermediateDirectories: true)
        } catch {
            return .failure(.directoryError)
        }
        
        let fileUrl = folderUrl.appendingPathComponent(fileId, conformingTo: .png)
        
        do {
            try pngData.write(to: fileUrl)
            return .success(fileUrl)
        } catch {
            return .failure(.cantSaveImage)
        }
    }
    
    
    func findImage(folder: fileFolderPath, id: String) -> Result<UIImage, ImageFileManagerError> {
    
        let ifUrl = findFileUrl(folder: folder, id: id)
        
        guard case .success(let fileUrl) = ifUrl else {
            return .failure(.directoryError)
        }

       
        if !fileManager.fileExists(
            atPath: getPath(url: fileUrl)
        ) {
            return .failure(.imageNotFound)
        }
        
        do {
            let imageData = try Data(contentsOf: fileUrl)
            guard let image = UIImage(data: imageData) else {
                return .failure(.cantLoadImage)
            }
            return .success(image)
        } catch {
            return .failure(.imageNotFound)
        }
    }
    
    
    func removeImage(folder: fileFolderPath, id: String) -> Result<Void, ImageFileManagerError> {
        
        let ifUrl = findFileUrl(folder: folder, id: id)
        
        guard case .success(let fileUrl) = ifUrl else {
            return .failure(.directoryError)
        }
        
        if !fileManager.fileExists(
            atPath: getPath(url: fileUrl)
        ) {
            return .failure(.imageNotFound)
        }
        
        do {
            try fileManager.removeItem(
                atPath: getPath(url: fileUrl)
            )
            
            let contents = try fileManager.contentsOfDirectory(atPath: folder.path)
            
            if contents.isEmpty {
                try fileManager.removeItem(atPath: folder.path)
            }
            return .success(())
        } catch {
            return .failure(.cantRemoveImage)
        }
    }
    
    private
    func findFileUrl(folder: fileFolderPath, id: String) -> Result<URL,ImageFileManagerError> {
        guard let directory = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else {
            return .failure(.directoryError)
        }
        
        let folderUrl = directory.appendingPathComponent(folder.path, conformingTo: .folder)
        
        let fileUrl = folderUrl.appendingPathComponent(id, conformingTo: .png)
        
        return .success(fileUrl)
    }

    
    private
    func getPath(url: URL) -> String {
        if #available(iOS 16.0, *) {
            return url.path()
        } else {
            return url.path
        }
    }
}


