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

class MemberOrderTransactionController: UIViewController, UITextFieldDelegate, MemberOrderTransactionViewDelegate {
    
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
    
    var transaction: TransactionModel =
        TransactionModel(
            title: "Bukber BSD",
            amount: 200000,
            date: Date(),
            personsOrders: [
                PersonsOrdersModel(
                    person: ContactModel(
                        name: "Ghozy Ghulamul Afif",
                        email: "ghozyghlmlaff@gmail.com"),
                    total: 100000,
                    orders: [
                        OrderModel(
                            name: "Ramen Reguler Ikkudo Ichi",
                            quantity: 1,
                            price: 70000,
                            amount: 70000),
                        OrderModel(
                            name: "Josu Ikkudo Ichi",
                            quantity: 1,
                            price: 30000,
                            amount: 30000)
                    ]),
                PersonsOrdersModel(
                    person: ContactModel(
                        name: "Rizky Febian",
                        email: "rizkysr19@gmail.com"),
                    total: 100000,
                    orders: [
                        OrderModel(
                            name: "Ramen Reguler Ikkudo Ichi",
                            quantity: 1,
                            price: 70000,
                            amount: 70000),
                        OrderModel(
                            name: "Josu Ikkudo Ichi",
                            quantity: 1,
                            price: 30000,
                            amount: 30000)
                    ])],
            orders: [
                OrderModel(
                    name: "Ramen Reguler Ikkudo Ichi",
                    quantity: 2,
                    price: 70000,
                    amount: 140000),
                OrderModel(
                    name: "Josu Ikkudo Ichi",
                    quantity: 2,
                    price: 30000,
                    amount: 60000)
            ])
    
    
    // MARK: - delegate object initialization
    weak var delegate: MemberOrderTransactionControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "MemberOrderTransactionView", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "memberOrderTransactionViewCellID")
    }
    
    // MARK: - Controls action
    @IBAction func saveAction(_ sender: UIButton) {
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
    
    func addMoreRow() {
        self.orderCount += 1
        self.tableView.reloadData()
    }
}

extension MemberOrderTransactionController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transaction.personsOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "memberOrderTransactionViewCellID", for: indexPath) as? MemberOrderTransactionView)!
        
        cell.personName.text = "\(transaction.personsOrders[indexPath.row].person.name)'s order"
        
        //cleaning stackView to reuse it
        cell.stackView.subviews.forEach { (view) in
            if !(view is UILabel) {
                view.removeFromSuperview()
            }
        }
        
        //Adding custom views to the stackView
        for order in transaction.personsOrders[indexPath.row].orders {
            let nib = MemberOrder()
            nib.name.text = order.name
            nib.quantity.text = "x\(order.quantity)"
            if let amount = NumberFormatter.rupiahFormatter.string(from:Int(order.amount) as NSNumber) {
                nib.amount.text = "Rp. \(amount)"
            }
            
            
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

