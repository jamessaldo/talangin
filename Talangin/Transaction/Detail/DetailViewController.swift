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
    var dataToBeUpdate: TransactionModel?
    var isUpdated: Bool? = false
    
    // MARK: - delegate object initialization
    weak var delegate: DetailViewControllerDelegate?
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        if let data = dataToBeUpdate {
            name.text = data.title
            date.text = DateFormatter.mediumDateFormatter.string(from: data.date)
            totalAmount.text = "Rp. \(Int(data.amount))"
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
    @IBAction func cancelAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = self.dataToBeUpdate {
            return data.personsOrders.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "detailViewCellID", for: indexPath) as? DetailViewCell)!
        if let data = self.dataToBeUpdate {
            cell.personName.text = "\(data.personsOrders[indexPath.row].person.name)'s total"
            cell.totalAmount.text = "Rp. \(Int(data.personsOrders[indexPath.row].total))"
            
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
                nib.amount.text = "Rp. \(Int(order.amount))"
                
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
