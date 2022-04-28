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
    var transactionLists: [TransactionModel] = [
        TransactionModel(title: "Bukber BSD", amount: 200000, date: Date(), personsOrders: [
            PersonsOrdersModel(person: ContactModel(name: "Ghozy Ghulamul Afif", email: "ghozyghlmlaff@gmail.com"), total: 100000, orders: [OrderModel(name: "Ramen Reguler Ikkudo Ichi", quantity: 1, price: 70000, amount: 70000),OrderModel(name: "Josu Ikkudo Ichi", quantity: 1, price: 30000, amount: 30000)]),
            PersonsOrdersModel(person: ContactModel(name: "Rizky Febian", email: "rizkysr19@gmail.com"), total: 100000, orders: [OrderModel(name: "Ramen Reguler Ikkudo Ichi", quantity: 1, price: 70000, amount: 70000),OrderModel(name: "Josu Ikkudo Ichi", quantity: 1, price: 30000, amount: 30000)])
            ],
            orders: [
                OrderModel(name: "Ramen Reguler Ikkudo Ichi", quantity: 2, price: 70000, amount: 140000),
                OrderModel(name: "Josu Ikkudo Ichi", quantity: 2, price: 30000, amount: 60000)
        ])
    ]
    var selectedRow: TransactionModel?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TransactionCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "transactionCellID")
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
                detailVC?.dataToBeUpdate = data
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
        return transactionLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "transactionCellID", for: indexPath) as? TransactionCell)!
        cell.transactionTitle.text = transactionLists[indexPath.row].title
        cell.personCount.text = "\(transactionLists[indexPath.row].personsOrders.count) Persons"
        cell.date.text = DateFormatter.mediumDateFormatter.string(from: transactionLists[indexPath.row].date)
        cell.totalAmount.text = "Rp. \(Int(transactionLists[indexPath.row].amount))"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = transactionLists[indexPath.row]
        displayDetail(isDisplayDetail: true)
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
