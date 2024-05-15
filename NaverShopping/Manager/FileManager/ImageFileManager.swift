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
    
    func saveImage(image: UIImage, folderPath: fileFolderPath, fileId: String) -> Result<Void, ImageFileManagerError>{
        
        guard let image = image.pngData() else {
            return .failure(.cantZip)
        }
        
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
            try image.write(to: fileUrl)
            return .success(())
        } catch {
            return .failure(.cantSaveImage)
        }
    }
    
    
    
    func findImage(folder: fileFolderPath, id: String) -> Result<UIImage, ImageFileManagerError> {
    
        let ifUrl = findFileUrl(folder: folder, id: id)
        
        guard case .success(let fileUrl) = ifUrl else {
            return .failure(.directoryError)
        }

        if !fileManager.fileExists(atPath: fileUrl.path()) {
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
        
        if !fileManager.fileExists(atPath: fileUrl.path()) {
            return .failure(.imageNotFound)
        }
        
        do {
            try fileManager.removeItem(atPath: fileUrl.path())
            
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
}


