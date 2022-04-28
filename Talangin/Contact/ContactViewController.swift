//
//  ContactViewController.swift
//  My Diary
//
//  Created by zy on 27/04/22.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var contactLists: [ContactModel] = [ContactModel(name: "Ghozy Ghulamul Afif", email: "ghozyghlmlaff@gmail.com"),
                                   ContactModel(name: "Rizky Febian", email: "rizkysr19@gmail.com"),
                                   ContactModel(name: "James Saldo", email: "jamessaldo19@gmail.com"),
                                   ContactModel(name: "Si Ipul", email: "mayarrezeki@gmail.com"),
                                   ContactModel(name: "Si Upil", email: "mayartestprod@gmail.com")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
}

extension ContactViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "contactCellID", for: indexPath) as? ContactCell)!
        cell.contactName.text = contactLists[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
