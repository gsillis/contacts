import UIKit

protocol ImagePickerSelectedPhoto {
    func imagePickerSelectedPhoto(_ photo: UIImage)
}

enum optionsMenu {
    case camera
    case galery
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
    
    func optionsMenu(completion: @escaping(_ option: optionsMenu) -> Void) -> UIAlertController {
        let options = UIAlertController(title: "Atenção", message: "Escolha uma das opções abaixo", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Tirar foto", style: .default) { action in
            completion(.camera)
        }
        options.addAction(camera)
        
        let galery = UIAlertAction(title: "Escolher da galeria", style: .default) { action in
            completion(.galery)
        }
        options.addAction(galery)
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        options.addAction(cancel)
        
        return options
    }
}

//fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
//    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
//}
//
//fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
//    return input.rawValue
//}
