//
//  ViewController.swift
//  Talangin
//
//  Created by zy on 27/04/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, DetailViewControllerDelegate, NewTransactionControllerDelegate {
    
    // MARK: - Input element & outlet connection
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingButton: UIButton! {
        didSet {
            floatingButton.drawACircle()
        }
    }
    
    // MARK: - Object initialization & Optional
    var transactionLists: [TransactionModel] = []
    var selectedRow: TransactionModel?
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //        let fetchRequest = NSFetchRequest<People>(entityName: "People")
        
        do {
            let transactions = try managedObjectContext.fetch(Transactions.fetchRequest())
            for t in transactions {
                var data: TransactionModel = TransactionModel()
                data.title = t.title ?? ""
                data.amount = t.amount 
                data.date = t.date ?? Date()
                let orders = t.orders?.allObjects as! [Orders]
                var ordersData: [OrderModel] = []
                for o in orders {
                    ordersData.append(OrderModel(name: o.name ?? "", quantity: Int(o.quantity) , price: o.price , amount: Float(o.amount) , totalMember: Int(o.totalMembers)))
                }
                data.orders = ordersData
                let personOrders = t.personOrders?.allObjects as! [PersonOrders]
                var personOrdersData: [PersonsOrdersModel] = []
                for po in personOrders {
                    let orders = po.orders?.allObjects as! [Orders]
                    var ordersData: [OrderModel] = []
                    for o in orders {
                        ordersData.append(OrderModel(name: o.name ?? "", quantity: Int(o.quantity) , price: o.price , amount: Float(o.amount) , totalMember: Int(o.totalMembers)))
                    }
                    let contact = ContactModel(name: po.person?.name ?? "", email: po.person?.email ?? "")
                    personOrdersData.append(PersonsOrdersModel(person: contact, total: po.total, orders: ordersData))
                }
                data.personsOrders = personOrdersData
                transactionLists.append(data)
            }
        } catch let error as NSError {
            print(error)
            print("error while fetching data in core data!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TransactionCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "transactionCellID")
    }
    
    // MARK: - Controls
    
    /* Here we know that every UI element that act as controls has an action that can be define directly without Outlet connection needed */
    @IBAction func floatingButtonAction(_ sender: UIButton) {
        selectedRow = nil
        displayDetail(isDisplayDetail: true, identifier: "newTransaction")
    }
    
    // MARK: - Function
    
    func displayDetail(isDisplayDetail: Bool, identifier: String) {
        if isDisplayDetail {
            self.performSegue(withIdentifier: identifier, sender: self)
        }
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailTransaction" {
            let detailVC = segue.destination as? DetailViewController
            // since we already subscribe the delegate from second page, we need to connect it to here
            if let data = selectedRow {
                detailVC?.data = data
            }
            detailVC?.delegate = self
        }
        if segue.identifier == "newTransaction" {
            let newTransaction = segue.destination as? NewTransactionController
            // since we already subscribe the delegate from second page, we need to connect it to here
            newTransaction?.delegate = self
        }
    }
    
    
    // MARK: - Our own delegate method
    func displayAlert(message: String?) {
        if let text = message {
            print(text)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "transactionCellID", for: indexPath) as? TransactionCell)!
        cell.transactionTitle.text = transactionLists[indexPath.row].title
        cell.personCount.text = "\(transactionLists[indexPath.row].personsOrders.count) Persons"
        cell.date.text = DateFormatter.mediumDateFormatter.string(from: transactionLists[indexPath.row].date)
        if let amount = NumberFormatter.rupiahFormatter.string(from:Int(transactionLists[indexPath.row].amount) as NSNumber) {
            cell.totalAmount.text = amount
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = transactionLists[indexPath.row]
        displayDetail(isDisplayDetail: true, identifier: "detailTransaction")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension DateFormatter {
    static let mediumDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        df.dateFormat = "dd/MM/YY"
        return df
    }()
}

extension NumberFormatter {
    static let rupiahFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "id_ID")
        nf.groupingSeparator = ","
        nf.numberStyle = .currency
        return nf
    }()
}

