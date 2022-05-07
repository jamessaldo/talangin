//
//  MemberOrderController.swift
//  Talangin
//
//  Created by zy on 03/05/22.
//

import UIKit

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
        for cell in self.tableView.visibleCells {
            if let cell = cell as? MemberOrderTransactionView {
//                var orders: [OrderModel] = []
                var total: Float = 0
                cell.stackView.arrangedSubviews.forEach { (view) in
                    if let sv = view as? MemberOrder {
//                        orders.append(sv.data ?? OrderModel())
                        
                        var amount = sv.amount.text ?? "0"
                        let removedChar: Set<Character> = ["R","p", "."]
                        amount.removeAll(where: { removedChar.contains($0)})
                        total += Float(amount) ?? 0
                        totalAmount += Float(amount) ?? 0
                    }
                }
                self.transactionData?.amount = totalAmount
                if let index = self.transactionData?.personsOrders.firstIndex(where: {$0.person?.name == cell.contact.name}){
                    self.transactionData?.personsOrders[index].total = total
                }
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

