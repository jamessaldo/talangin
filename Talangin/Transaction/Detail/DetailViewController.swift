//
//  DetailViewController.swift
//  My Diary
//
//  Created by zy on 27/04/22.
//

import UIKit

// MARK: - Protocol for our own delegate
protocol DetailViewControllerDelegate: AnyObject {
    // Delegate method that can be used
    func displayAlert(message:String?)
}

class DetailViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Output element & Outlet connection
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton! {
        didSet {
            saveButton.drawARoundedCorner()
        }
    }
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    // MARK: - Object initialization & Optional
    var data: TransactionModel?
    
    // MARK: - delegate object initialization
    weak var delegate: DetailViewControllerDelegate?
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        if let data = data {
            name.text = data.title
            date.text = DateFormatter.mediumDateFormatter.string(from: data.date)
            if let amount = NumberFormatter.rupiahFormatter.string(from:Int(data.amount) as NSNumber) {
                totalAmount.text = amount
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nib = UINib(nibName: "DetailViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "detailViewCellID")
    }
    
    // MARK: - Controls action
    @IBAction func saveAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.displayAlert(message:"Uhuy")
        }
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = self.data {
            return data.personsOrders.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "detailViewCellID", for: indexPath) as? DetailViewCell)!
        if let data = self.data {
            cell.personName.text = "\(data.personsOrders[indexPath.row].person?.name ?? "Person \(indexPath.row + 1)")'s total"
            if let amount = NumberFormatter.rupiahFormatter.string(from:Int(data.personsOrders[indexPath.row].total) as NSNumber) {
                cell.totalAmount.text = amount
            }
            
            //cleaning stackView to reuse it
            cell.stackView.subviews.forEach { (view) in
                if !(view is UILabel) {
                    view.removeFromSuperview()
                }
            }
            
            //Adding custom views to the stackView
            for order in data.personsOrders[indexPath.row].orders {
                let nib = DetailTransactionView()
                nib.name.text = order.name
                nib.quantity.text = "x\(order.quantity)"
                if let index = self.data?.orders.firstIndex(where: { $0.name == order.name}){
                    if let amount = NumberFormatter.rupiahFormatter.string(from:Int(Int(order.amount) / (self.data?.orders[index].totalMember ?? 1)) as NSNumber) {
                        nib.amount.text = amount
                    }
                }
                
                let border = UIView()
                border.backgroundColor = .gray
                border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
                border.frame = CGRect(x: 20, y: 0, width: 374, height: 1)
                cell.stackView.addSubview(border)
                
                cell.stackView.addArrangedSubview(nib)
            }
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
