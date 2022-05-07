//
//  ContactViewController.swift
//  My Diary
//
//  Created by zy on 27/04/22.
//

import UIKit
import CoreData

class ContactViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var contactLists: [ContactModel] = [ContactModel(name: "Ghozy Ghulamul Afif", email: "ghozyghlmlaff@gmail.com"),
                                        ContactModel(name: "Rizky Febian", email: "rizkysr19@gmail.com"),
                                        ContactModel(name: "James Saldo", email: "jamessaldo19@gmail.com"),
                                        ContactModel(name: "Si Ipul", email: "mayarrezeki@gmail.com"),
                                        ContactModel(name: "Si Upil", email: "mayartestprod@gmail.com")]
    var contacts: [People] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
//        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//        let entityDescripition = NSEntityDescription.entity(forEntityName: "People", in: managedObjectContext)
//        for c in contactLists {
//            let contact = People(entity: entityDescripition!, insertInto: managedObjectContext)
//            contact.name = c.name
//            contact.email = c.email
//            do {
//                try managedObjectContext.save()
//            } catch _ {
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<People>(entityName: "People")

        do {
            contacts = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
    }
    
}

extension ContactViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = contacts[indexPath.row]
        let cell = (tableView.dequeueReusableCell(withIdentifier: "contactCellID", for: indexPath) as? ContactCell)!
        cell.contactName.text = contact.name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
