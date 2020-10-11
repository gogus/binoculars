import UIKit

class ListViewController: UITableViewController {
    
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Places list"
    
    
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let file = "file.txt"
    var count = 0

    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(file)
        
        //reading
        do {
            let data = try Data(contentsOf: fileURL)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [[String: Any]] {
              for item in object {
                count = count + 1
              }
            } else {
              print("Could not read the JSON.")
            }
        }
        catch {/* error handling here */}
    }
    
    return count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
    let cellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ??
      UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
    
    cell.accessoryType = .disclosureIndicator

    let file = "file.txt"
    var count = 0

    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(file)
        
        //reading
        do {
            let data = try Data(contentsOf: fileURL)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [[String: Any]] {
              for item in object {
               
                
                if (count == indexPath.item) {
                    cell.textLabel?.text = item["name"] as! String
                    cell.detailTextLabel?.text = (item["currentpopular"] as! Float).description + "% of estimated traffic currently"
                }
                
                count = count + 1
              }
            } else {
              print("Could not read the JSON.")
            }
        }
        catch {/* error handling here */}
    }
    
      return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

  }
}
