import UIKit

struct MenuItem {
    var name: String
    var price: Int
}

class ViewController: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeCell", for: indexPath) as! CoffeeCell
        let coffee = items[indexPath.row]
        
        cell.menuName.text = coffee.name
        cell.price.text = "\(coffee.price)"
        
        return cell
        
//        var identifier: String = ""
//        if indexPath.row == 0 {
//            identifier = "MenuItem"
//        } else {
//            identifier = "SubtitleItem"
//        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//        cell.textLabel?.text = items[indexPath.row].name
//        cell.detailTextLabel?.text = "\(items[indexPath.row].price)"
//        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var items:[MenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        API.shared.hello()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        API.shared.getMenuItems(completion: { menu in
            self.items = menu
            self.tableView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menuDetail" {
            let vc = segue.destination as! CoffeeDetailViewController
            vc.menu = sender as! MenuItem
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.items[indexPath.row])
        performSegue(withIdentifier: "menuDetail", sender: self.items[indexPath.row])
    }
}
