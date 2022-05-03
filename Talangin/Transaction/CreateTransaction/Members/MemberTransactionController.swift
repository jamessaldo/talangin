//
//  MemberTransactionController.swift
//  Talangin
//
//  Created by zy on 03/05/22.
//

import UIKit

// MARK: - Protocol for our own delegate
protocol MemberTransactionControllerDelegate: AnyObject {
    // Delegate method that can be used
    //    func displayAlert(message:String?)
    func dismissModal()
}

class MemberTransactionController: UIViewController, UITextFieldDelegate, MemberTransactionViewDelegate, MemberOrderTransactionControllerDelegate {
    
    // MARK: - Output element & Outlet connection
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.drawARoundedCorner()
        }
    }
    @IBOutlet weak var cancelButton: UIButton! {
        didSet {
            cancelButton.drawARoundedCorner()
            cancelButton.drawABorder()
        }
    }
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    // MARK: - Object initialization & Optional
    var newDataToBeSave: TransactionModel?
    var isUpdated: Bool = false
    var listNewOrders: [OrderModel] = []
    var orderCount: Int = 1
    
    var contactLists: [ContactModel] = [ContactModel(name: "Ghozy Ghulamul Afif", email: "ghozyghlmlaff@gmail.com"),
                                        ContactModel(name: "Rizky Febian", email: "rizkysr19@gmail.com"),
                                        ContactModel(name: "James Saldo", email: "jamessaldo19@gmail.com"),
                                        ContactModel(name: "Si Ipul", email: "mayarrezeki@gmail.com"),
                                        ContactModel(name: "Si Upil", email: "mayartestprod@gmail.com")]
    
    // MARK: - delegate object initialization
    weak var delegate: MemberTransactionControllerDelegate?
    
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
            memberOrder?.delegate = self
        }
    }
    
    
    // MARK: - Controls action
    @IBAction func saveAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "memberToMemberOrder", sender: self)
    }
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func addMoreRow() {
        self.orderCount += 1
        self.tableView.reloadData()
    }
    
    func dismissModal() {
        self.dismiss(animated: true)
        self.delegate?.dismissModal()
    }
}

extension MemberTransactionController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "memberTransactionViewCellID", for: indexPath) as? MemberTransactionView)!
        cell.contactName.text = contactLists[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contactLists[indexPath.row].isSelected = true
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        contactLists[indexPath.row].isSelected = false
    }
}
