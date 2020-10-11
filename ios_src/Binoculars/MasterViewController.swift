import UIKit

class MasterViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Binoculars"
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Sample.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
      let cellIdentifier = "Cell"
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ??
        UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
      
      cell.accessoryType = .disclosureIndicator
      cell.textLabel?.text = Sample.allCases[indexPath.item].title
      cell.detailTextLabel?.text = Sample.allCases[indexPath.item].description
      return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let navigationController = navigationController {
      let viewController = Sample.allCases[indexPath.item].controller.init()
      navigationController.pushViewController(viewController, animated: true)
    }
  }
}
