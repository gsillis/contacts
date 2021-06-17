import UIKit
import CoreData

class AlunoViewController: UIViewController, ImagePickerSelectedPhoto {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var viewImagemAluno: UIView!
    @IBOutlet weak var imageAluno: UIImageView!
    @IBOutlet weak var buttonFoto: UIButton!
    @IBOutlet weak var scrollViewPrincipal: UIScrollView!
    
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldEndereco: UITextField!
    @IBOutlet weak var textFieldTelefone: UITextField!
    @IBOutlet weak var textFieldSite: UITextField!
    @IBOutlet weak var textFieldNota: UITextField!
    
    //MARK: - Atributos

    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    var imagePicker = ImagePicker()
    var contact: Contact?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arredondaView()
        self.setUp()
        NotificationCenter.default.addObserver(self, selector: #selector(aumentarScrollView(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Métodos
    
    func setUp() {
        imagePicker.delegate = self
        guard let selectedContact = contact else { return }
        textFieldNome.text = selectedContact.name
        textFieldEndereco.text = selectedContact.address
        textFieldTelefone.text = selectedContact.phone
        textFieldSite.text = selectedContact.site
        textFieldNota.text = String(selectedContact.nota)
        imageAluno.image = selectedContact.photo as? UIImage
    }
    
    func arredondaView() {
        self.viewImagemAluno.layer.cornerRadius = self.viewImagemAluno.frame.width / 2
        self.viewImagemAluno.layer.borderWidth = 1
        self.viewImagemAluno.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @objc func aumentarScrollView(_ notification:Notification) {
        self.scrollViewPrincipal.contentSize = CGSize(width: self.scrollViewPrincipal.frame.width, height: self.scrollViewPrincipal.frame.height + self.scrollViewPrincipal.frame.height/2)
    }
    
    func showMedia(_ option: optionsMenu) {
        let multimidia = UIImagePickerController()
        multimidia.delegate = imagePicker
        
        if option == .camera && UIImagePickerController.isSourceTypeAvailable(.camera) {
            multimidia.sourceType = .camera
        } else {
            multimidia.sourceType = .photoLibrary
        }
        self.present(multimidia, animated: true, completion: nil)
    }
    
    //MARK: - Delegate
    
    func imagePickerSelectedPhoto(_ photo: UIImage) {
        imageAluno.image = photo
    }
    
    // MARK: - IBActions
    
    @IBAction func buttonFoto(_ sender: UIButton) {
        let menu = ImagePicker().optionsMenu { option in
            self.showMedia(option)
        }
        present(menu, animated: true, completion: nil)
    }
    
    @IBAction func stepperNota(_ sender: UIStepper) {
        self.textFieldNota.text = "\(sender.value)"
    }
    
    @IBAction func buttonSave(_ sender: Any) {
        if contact == nil {
            contact = Contact(context: context)
        }
        contact?.name = textFieldNome.text
        contact?.address = textFieldEndereco.text
        contact?.nota = (textFieldNota.text! as NSString).doubleValue
        contact?.phone = textFieldTelefone.text
        contact?.photo = imageAluno.image
        contact?.site = textFieldSite.text
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
}
