//
//  MemberOrderController.swift
//  Talangin
//
//  Created by zy on 03/05/22.
//

import UIKit
import CoreData

// MARK: - Protocol for our own delegate
protocol MemberOrderTransactionControllerDelegate: AnyObject {
    // Delegate method that can be used
    //    func displayAlert(message:String?)
}

class MemberOrderTransactionController: UIViewController, UITextFieldDelegate, MemberOrderTransactionViewDelegate, SelectOrderControllerDelegate {
    
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
    
    // MARK: - Object initialization & Optional
    var orderCount: Int = 1
    var transactionData: TransactionModel?
    var totalAmount: Float = 0
    var indexPerson: Int?
    // MARK: - delegate object initialization
    weak var delegate: MemberOrderTransactionControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "MemberOrderTransactionView", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "memberOrderTransactionViewCellID")
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectOrder" {
            let selectOrder = segue.destination as? SelectOrderController
            // since we already subscribe the delegate from second page, we need to connect it to here
            
            selectOrder?.transactionData = transactionData
            selectOrder?.indexPerson = self.indexPerson
            selectOrder?.delegate = self
        }
    }
    
    // MARK: - Controls action
    @IBAction func saveAction(_ sender: UIButton) {
        for (idx, cell) in self.tableView.visibleCells.enumerated() {
            if let cell = cell as? MemberOrderTransactionView {
                //                var orders: [OrderModel] = []
                var total: Float = 0
                cell.stackView.arrangedSubviews.forEach { (view) in
                    if let sv = view as? MemberOrder {
                        var amount = sv.amount.text ?? "0"
                        let removedChar: Set<Character> = ["R","p", "."]
                        amount.removeAll(where: { removedChar.contains($0)})
                        total += Float(amount) ?? 0
                        totalAmount += Float(amount) ?? 0
                    }
                }
                self.transactionData?.amount = totalAmount
                self.transactionData?.personsOrders[idx].total = total
            }
        }
        print(self.transactionData ?? TransactionModel())
        
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let transactionsEntity = NSEntityDescription.entity(forEntityName: "Transactions", in: managedObjectContext)
        let transaction = Transactions(entity: transactionsEntity!, insertInto: managedObjectContext)
        transaction.title = self.transactionData?.title
        transaction.date = Date()
        transaction.amount = self.transactionData?.amount ?? 0
        
        do {
            try managedObjectContext.save()
        } catch _ {
        }
        
        var orderLists: [Orders] = []
        let ordersEntity = NSEntityDescription.entity(forEntityName: "Orders", in: managedObjectContext)
        for o in self.transactionData?.orders ?? [] {
            let order = Orders(entity: ordersEntity!, insertInto: managedObjectContext)
            order.name = o.name
            order.quantity = Int32(o.quantity)
            order.price = o.price
            order.amount = Int32(o.amount)
            order.totalMembers = Int32(o.totalMember)
            order.transaction = transaction
            orderLists.append(order)
            do {
                try managedObjectContext.save()
            } catch _ {
            }
        }
        
        let personOrdersEntity = NSEntityDescription.entity(forEntityName: "PersonOrders", in: managedObjectContext)
        for data in self.transactionData?.personsOrders ?? [] {
            let po = PersonOrders(entity: personOrdersEntity!, insertInto: managedObjectContext)
            po.total = data.total
            po.transactions = transaction
            var orders: [Orders] = []
            for o in orderLists {
                if let _ = data.orders.firstIndex(where: { $0.name == o.name}) {
                    orders.append(o)
                }
            }
            po.orders = NSSet(array: orders)
            let fetchRequest = People.fetchRequest()
            fetchRequest.predicate = NSPredicate(
                format: "email = %@", data.person?.email ?? ""
            )
            fetchRequest.fetchLimit = 1
            do {
                let person = try managedObjectContext.fetch(fetchRequest).first
                po.person = person
            } catch _ {
            }
            do {
                try managedObjectContext.save()
            } catch _ {
            }
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as!
        UITabBarController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as!
        UITabBarController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func addMoreRow(indexPerson: Int) {
        //        self.orderCount += 1
        self.indexPerson = indexPerson
        self.performSegue(withIdentifier: "selectOrder", sender: self)
    }
    
    func handleSelectedOrder(transactionData: TransactionModel) {
        self.transactionData = transactionData
        self.tableView.reloadData()
    }
}

extension MemberOrderTransactionController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionData?.personsOrders.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "memberOrderTransactionViewCellID", for: indexPath) as? MemberOrderTransactionView)!
        let data = transactionData?.personsOrders[indexPath.row]
        cell.personName.text = "\(data?.person?.name ?? "Person \(indexPath.row + 1)")'s order"
        //        cell.contact = data?.person
        cell.indexPerson = indexPath.row
        cell.delegate = self
        //cleaning stackView to reuse it
        cell.stackView.arrangedSubviews.forEach { (view) in
            if !(view is UILabel) {
                view.removeFromSuperview()
            }
        }
        
        //Adding custom views to the stackView
        for order in data?.orders ?? []{
            let nib = MemberOrder()
            nib.name.text = order.name
            nib.quantity.text = "x\(order.quantity)"
            if let index = self.transactionData?.orders.firstIndex(where: { $0.name == order.name}){
                if let amount = NumberFormatter.rupiahFormatter.string(from:Int(Int(order.amount) / (self.transactionData?.orders[index].totalMember ?? 1)) as NSNumber) {
                    nib.amount.text = amount
                }
            }
            
            nib.data = order
            nib.data?.amount = order.amount/2
            
            let border = UIView()
            border.backgroundColor = .gray
            border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
            border.frame = CGRect(x: 20, y: 0, width: 374, height: 1)
            cell.stackView.addSubview(border)
            
            cell.stackView.addArrangedSubview(nib)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

