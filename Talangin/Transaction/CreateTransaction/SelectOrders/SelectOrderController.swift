//
//  SelectOrderController.swift
//  Talangin
//
//  Created by zy on 03/05/22.
//

import UIKit

// MARK: - Protocol for our own delegate
protocol SelectOrderControllerDelegate: AnyObject {
    // Delegate method that can be used
    func handleSelectedOrder(transactionData: TransactionModel)
}

class SelectOrderController: UIViewController, UITextFieldDelegate, SelectOrderViewDelegate {
    
    // MARK: - Output element & Outlet connection
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.drawARoundedCorner()
        }
    }
    
    // MARK: - Object initialization & Optional
    var transactionData: TransactionModel?
    var indexPerson: Int?
    
    // MARK: - delegate object initialization
    weak var delegate: SelectOrderControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "SelectOrderView", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "selectOrderViewCellID")
        self.tableView?.allowsMultipleSelection = true
    }
    
    // MARK: - Controls action
    @IBAction func saveAction(_ sender: UIButton) {
        for cell in self.tableView.visibleCells {
            if cell.isSelected {
                if let cell = cell as? SelectOrderView {
                    if self.transactionData?.personsOrders[self.indexPerson ?? 0].orders.filter({$0.name == cell.contactName.text}).count == 0{
                        if let index = self.transactionData?.orders.firstIndex(where: { $0.name == cell.contactName.text}){
                            self.transactionData?.orders[index].totalMember += 1
                        }
                        self.transactionData?.personsOrders[self.indexPerson ?? 0].orders.append(cell.contact ?? OrderModel())
                    }
                }
            } else {
                if let cell = cell as? SelectOrderView {
                    if let index = self.transactionData?.personsOrders[self.indexPerson ?? 0].orders.firstIndex(where: {$0.name == cell.contactName.text}) {
                        if let index = self.transactionData?.orders.firstIndex(where: { $0.name == cell.contactName.text}){
                            self.transactionData?.orders[index].totalMember -= 1
                        }
                        self.transactionData?.personsOrders[self.indexPerson ?? 0].orders.remove(at: index)
                    }
                }
            }
        }
        self.delegate?.handleSelectedOrder(transactionData: self.transactionData ?? TransactionModel())
        //        self.tableView.reloadData()
        self.dismiss(animated: true)
    }
}

extension SelectOrderController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionData?.orders.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "selectOrderViewCellID", for: indexPath) as? SelectOrderView)!
        cell.contactName.text = transactionData?.orders[indexPath.row].name
        cell.contact = transactionData?.orders[indexPath.row]
        if (transactionData?.personsOrders[self.indexPerson ?? 0].orders.firstIndex(where: {$0.name == cell.contactName.text})) != nil {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
