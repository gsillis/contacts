//
//  ImagePicker.swift
//  Agenda
//
//  Created by Gabriela Sillis on 07/06/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

protocol ImagePickerSelectedPhoto {
    func imagePickerSelectedPhoto(_ photo: UIImage)
}

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Atributos
    
    var delegate: ImagePickerSelectedPhoto?
    
    //MARK: - Métodos
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
        delegate?.imagePickerSelectedPhoto(photo)
        picker.dismiss(animated: true, completion: nil)
    }
}
