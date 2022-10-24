//
//  ExpenseViewController.swift
//  Expense Tracker
//
//  Created by Sneha Seenuvasavarathan on 10/23/22.
//

import UIKit
import CoreData
class ExpenseViewController: UIViewController  {
    
    var bills:[Expense]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var totalExpenses: UILabel!
    @IBOutlet weak var expenseTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        expenseTable.delegate = self
        expenseTable.dataSource = self
        fetchBills()
        expenseTable.reloadData()
        // Do any additional setup after loading the view.
        
        
        //To Delete Everything in Expenses
        
        //for object in bills!{
           // context.delete(object)
       // }
        
        //do{
        //    try context.save()
       // }catch{}
        
    }
    
    func fetchBills(with request: NSFetchRequest<Expense> = Expense.fetchRequest()){
        //Fetch the data from Core Data to displau in the tableview
        //context.
        do{
            bills = try context.fetch(request)
            DispatchQueue.main.async{
                self.expenseTable.reloadData()
            }
        }catch{
            print(error)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}


extension ExpenseViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.bills?.count ?? 0
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath)
        
            //cell.delegate = self
        let exp = cell.viewWithTag(4) as! UILabel
        let amount = cell.viewWithTag(6) as! UILabel
        let date = cell.viewWithTag(5) as! UILabel
        
        let expense = self.bills![indexPath.row]
        exp.text = expense.title
        amount.text = "\(expense.amount)"
        date.text = "\(expense.date!.formatted(date: .abbreviated, time: .omitted))"
            return cell
        }

    
    
}
