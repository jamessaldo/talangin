//
//  ViewController.swift
//  Talangin
//
//  Created by zy on 27/04/22.
//

import UIKit

class ViewController: UIViewController, DetailViewControllerDelegate {
    
    // MARK: - Input element & outlet connection
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingButton: UIButton! {
        didSet {
            floatingButton.drawACircle()
        }
    }
    
    // MARK: - Object initialization & Optional
    var contactLists: [ContactModel] = [ContactModel(name: "Ghozy Ghulamul Afif", email: "ghozyghlmlaff@gmail.com"),
                                        ContactModel(name: "Rizky Febian", email: "rizkysr19@gmail.com"),
                                        ContactModel(name: "James Saldo", email: "jamessaldo19@gmail.com"),
                                        ContactModel(name: "Si Ipul", email: "mayarrezeki@gmail.com"),
                                        ContactModel(name: "Si Upil", email: "mayartestprod@gmail.com")]
    var selectedRow: ContactModel?
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Controls
    
    /* Here we know that every UI element that act as controls has an action that can be define directly without Outlet connection needed */
    @IBAction func floatingButtonAction(_ sender: UIButton) {
        selectedRow = nil
        displayDetail(isDisplayDetail: true)
    }
    
    // MARK: - Function
    
    func displayDetail(isDisplayDetail: Bool) {
        if isDisplayDetail {
            self.performSegue(withIdentifier: "detailTransaction", sender: self)
        }
    }
    
    // MARK: - Segue
    
    // Now we want to sent the story value to detail page and display it there, so we need this method in order to do that
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailTransaction" {
            let detailVC = segue.destination as? DetailViewController
            // since we already subscribe the delegate from second page, we need to connect it to here
            if let data = selectedRow {
                print(data.name)
                detailVC?.dataToBeUpdate = data.name
                detailVC?.isUpdated = true
            }
            detailVC?.delegate = self
        }
    }
    
    
    // MARK: - Our own delegate method
    
    // This displayAlert method available to use here, because we already subscribe the delegate from the detail page.
    func displayAlert(message: String?) {
        if let text = message {
            print(text)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "transactionCellID", for: indexPath) as? TransactionCell)!
        cell.transactionTitle.text = contactLists[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = contactLists[indexPath.row]
        displayDetail(isDisplayDetail: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

