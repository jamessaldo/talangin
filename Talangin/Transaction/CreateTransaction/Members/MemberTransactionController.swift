//
//  MemberTransactionController.swift
//  Talangin
//
//  Created by zy on 03/05/22.
//

import UIKit
import CoreData

// MARK: - Protocol for our own delegate
protocol MemberTransactionControllerDelegate: AnyObject {
    // Delegate method that can be used
}

class MemberTransactionController: UIViewController, UITextFieldDelegate, MemberTransactionViewDelegate, MemberOrderTransactionControllerDelegate {
    
    // MARK: - Output element & Outlet connection
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.drawARoundedCorner()
        }
    }
    
    // MARK: - Object initialization & Optional
    var contactLists: [ContactModel] = []
    var transactionData: TransactionModel?
    
    // MARK: - delegate object initialization
    weak var delegate: MemberTransactionControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<People>(entityName: "People")

        do {
            let people = try managedObjectContext.fetch(fetchRequest)
            for p in people {
                contactLists.append(ContactModel(name: p.name ?? "Unknown Name", email: p.email ?? "Unknown Email"))
            }
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "MemberTransactionView", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "memberTransactionViewCellID")
        self.tableView?.allowsMultipleSelection = true
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "memberToMemberOrder" {
            let memberOrder = segue.destination as? MemberOrderTransactionController
            // since we already subscribe the delegate from second page, we need to connect it to here
            transactionData?.personsOrders = []
            for cell in self.tableView.visibleCells {
                if cell.isSelected {
                    if let cell = cell as? MemberTransactionView {
                        transactionData?.personsOrders.append(PersonsOrdersModel(person: cell.contact ?? ContactModel()))
                    }
                }
            }
            memberOrder?.transactionData = transactionData
            memberOrder?.delegate = self
        }
    }
    
    
    // MARK: - Controls action
    @IBAction func saveAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "memberToMemberOrder", sender: self)
    }
}

extension MemberTransactionController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "memberTransactionViewCellID", for: indexPath) as? MemberTransactionView)!
        cell.contactName.text = contactLists[indexPath.row].name
        cell.contact = contactLists[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
