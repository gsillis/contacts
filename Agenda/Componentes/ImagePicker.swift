import UIKit

protocol ImagePickerSelectedPhoto {
    func imagePickerSelectedPhoto(_ photo: UIImage)
}

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Atributos
    
   public var delegate: ImagePickerSelectedPhoto?
    
    //MARK: - Métodos
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let photo = info[.originalImage] as? UIImage {
            self.delegate?.imagePickerSelectedPhoto(photo)
        } else {
            print ("Erro ao salvar a imagem")
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
