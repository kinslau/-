




import UIKit

protocol MenuTableViewControllerDelegate {
    func menuControllerDidSelectRow(indexPath:NSIndexPath)
}

class MenuTableViewController: UITableViewController {

    var delegate : MenuTableViewControllerDelegate?
    var tableData : Array<String> = []
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
 
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("CELL")
        
        if cell == nil{
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: "CELL")
            cell?.backgroundColor = UIColor.clearColor()
            cell?.textLabel?.textColor = UIColor.blackColor()

        }
        
        
        cell?.textLabel?.text = tableData[indexPath.row]
        
        return cell!

        
    }
    

    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 50.0
    }
    
    
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        delegate?.menuControllerDidSelectRow(indexPath)
        
    }
}
