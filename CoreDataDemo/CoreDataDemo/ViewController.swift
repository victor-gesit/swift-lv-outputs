import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var newItem: UITextField!
    var allItems: [NSManagedObject] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        itemsTableView.delegate = self;
        itemsTableView.dataSource = self;
        loadItems()
    }

    @IBAction func addItem(_ sender: Any) {
        let itemText = newItem.text
        if let text = itemText, !text.isEmpty {
            let context = appDelegate.persistentContainer.viewContext
            let itemEntity = NSEntityDescription.entity(forEntityName: "Items", in: context)
            if let entity = itemEntity {
                let newItem = NSManagedObject(entity: entity, insertInto: context)
                newItem.setValue(text, forKey: "name")
                do {
                    try context.save()
                    print("Saved item")
                    allItems.append(newItem)
                    itemsTableView.reloadData()
                } catch {
                    print("Saved failed with error \(error)")
                }
            }
            
        }
    }
    private func loadItems() {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        request.returnsObjectsAsFaults = false
        self.itemsTableView.reloadData()
        
        do {
            let result = try context.fetch(request)
            let items = result as? [NSManagedObject]
            if let items = items {
                for item in items {
                    allItems.append(item)
                }
                itemsTableView.reloadData()
            }
        } catch {
            print("Fetch failed with error \(error)")
        }
    }
    private func confirmDelete(itemIndex: IndexPath) {
        let alert = UIAlertController(title: "Delete Item?", message: "This item will be deleted", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.handleItemDelete(itemIndex: itemIndex)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    private func handleItemDelete(itemIndex: IndexPath) {
        let context = appDelegate.persistentContainer.viewContext
        context.delete(allItems[itemIndex.row])
        allItems.remove(at: itemIndex.row)
        itemsTableView.deleteRows(at: [itemIndex], with: .automatic)
    }
}

extension ViewController:  UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellId"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemTableViewCell else {
                return UITableViewCell()
        }
        let item = allItems[indexPath.row]
        let itemName = item.value(forKey: "name") as? String
        cell.itemLabel.text = itemName
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let indexPathToDelete = indexPath
            confirmDelete(itemIndex: indexPathToDelete)
        }
    }
    
}
