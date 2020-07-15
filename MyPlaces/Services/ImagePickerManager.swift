//
//  ImagePickerManager.swift
//  MyPlaces
//
//  Created by Максим Семений on 13.07.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

final class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var picker = UIImagePickerController();
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback: ((UIImage) -> ())?;
    
    override init(){
        super.init()
    }
    
    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true)
    }
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        
        AVCaptureDevice.requestAccess(for: .video) { (success) in
            if success {
                DispatchQueue.main.async {
                    self.picker.sourceType = .camera
                    self.viewController!.present(self.picker, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Camera", message: "Camera access is absolutely necessary to use this app", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }))
                self.viewController!.present(alert, animated: true)
            }
        }
    }
    func openGallery(){
        alert.dismiss(animated: true, completion: nil)
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    DispatchQueue.main.async {
                        self.picker.sourceType = .photoLibrary
                        self.viewController!.present(self.picker, animated: true)
                    }
                }
            }
        }
        
        if PHPhotoLibrary.authorizationStatus() == .denied {
            let alert = UIAlertController(title: "Photo Gallery", message: "Gallery access is absolutely necessary to use this app", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
            self.viewController!.present(alert, animated: true)
        }
        
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            DispatchQueue.main.async {
                self.picker.sourceType = .photoLibrary
                self.viewController!.present(self.picker, animated: true)
            }
        }

    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        pickImageCallback?(image)
    }
}
