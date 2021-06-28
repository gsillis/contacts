import UIKit
import  CoreData

class HomeTableViewController: UITableViewController, UISearchBarDelegate, NSFetchedResultsControllerDelegate {
    
    //MARK: - Variáveis
    
    let searchController = UISearchController(searchResultsController: nil)
    var manageResults: NSFetchedResultsController<Contact>?
    var contacViewController: AlunoViewController?
    var message = Message()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuraSearch()
        self.recoverContacts()
    }
    
    // MARK: - Métodos
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            contacViewController = segue.destination as? AlunoViewController
        }
    }
    
    func recoverContacts() {
        let searchContacts: NSFetchRequest<Contact> = Contact.fetchRequest()
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        searchContacts.sortDescriptors = [sortByName]
        
        manageResults = NSFetchedResultsController(fetchRequest: searchContacts,
                                                   managedObjectContext: AlunoViewController().context,
                                                   sectionNameKeyPath: nil , cacheName: nil)
        manageResults?.delegate = self
        
        do {
            try  manageResults?.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func configuraSearch() {
        self.searchController.searchBar.delegate = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
    
    @objc func openActionSheet(_ longPress: UILongPressGestureRecognizer) {
        if longPress.state == .began {
            guard let selectedContact = manageResults?.fetchedObjects?[(longPress.view?.tag)! ] else { return }
            let menu = OptionsMenu().optionsMenu { option in
                switch option {
                case .sms:
                    if let messageComponent = self.message.configSms(selectedContact) {
                        messageComponent.messageComposeDelegate = self.message
                        self.present(messageComponent, animated: true, completion: nil)
                    }
                    break
                case .call:
                    guard  let number = selectedContact.phone else { return }
                    if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                  break
                case .maps:
                    if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
                        guard let address = selectedContact.address else { return }
                        Localization().convertAddress(address: address) { locationFound in
                            let latitude = String(describing: locationFound.location?.coordinate.latitude)
                            let longitude = String(describing: locationFound.location?.coordinate.longitude)
                            let url:String = ("waze://?ll=\(latitude),\(longitude)&navigate=yes")
                            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
                        }
                    }
                }
            }
            self.present(menu, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let contactsList = manageResults?.fetchedObjects?.count ?? 0
        
        return contactsList
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula-aluno", for: indexPath) as! HomeTableViewCell
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(openActionSheet(_:)))
        guard let contact = manageResults?.fetchedObjects![indexPath.row] else {return cell}
        
        cell.configCell(contact)
        cell.addGestureRecognizer(longPress)
        longPress.view?.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let selectContact =  manageResults?.fetchedObjects![indexPath.row] else { return }
            AlunoViewController().context.delete(selectContact)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedContact = manageResults?.fetchedObjects![indexPath.row] else { return }
        contacViewController?.contact = selectedContact
    }
    
    //MARK - FetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any,
                    at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
            break
        default:
            tableView.reloadData()
        }
    }
}
