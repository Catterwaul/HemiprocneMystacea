public protocol dequeuedReusableCell {
associatedtype Cell: UIView

   ///- Attention: Called dequeueReusableCellWithIdentifier in UITableView
   func dequeueReusableCellWithReuseIdentifier(
      identifier: String,
      forIndexPath indexPath: NSIndexPath
   ) -> Cell
}


// This should be one function in one extension
// but it doesn't seem possible to express.

public extension dequeuedReusableCell where Self: UICollectionView {
   ///- Returns: A reusable cell dequeued without the standard need 
   ///  for passing its name as a `String`,
   ///  and then casting to the desired type
   ///
   ///- Precondition: The name of `Cell` has been assigned to the `Identifier`
   ///  for a cell that this Collection View uses
   final func dequeuedReusableCell<Cell: UICollectionViewCell>(forPath indexPath: NSIndexPath) -> Cell {
      return 😾dequeuedReusableCell(forPath: indexPath)
   }
}
public extension dequeuedReusableCell where Self: UITableView {
   ///- Returns: A reusable cell dequeued without the standard need 
   ///  for passing its name as a `String`,
   ///  and then casting to the desired type
   ///
   ///- Precondition: The name of `Cell` has been assigned to the `Identifier`
   ///  for a cell that this Table View uses
   final func dequeuedReusableCell<Cell: UITableViewCell>(forPath indexPath: NSIndexPath) -> Cell {
      return 😾dequeuedReusableCell(forPath: indexPath)
   }
}

private extension dequeuedReusableCell {
   final func 😾dequeuedReusableCell<Cell: UIView>(forPath indexPath: NSIndexPath) -> Cell {
      return dequeueReusableCellWithReuseIdentifier(String(Cell),
         forIndexPath: indexPath
      ) as! Cell
   }
}

//MARK:- Conformance
extension UICollectionView: dequeuedReusableCell {}
extension UITableView: dequeuedReusableCell {
   public final func dequeueReusableCellWithReuseIdentifier(
      identifier: String,
      forIndexPath indexPath: NSIndexPath
   ) -> UITableViewCell {
      return dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
   }
}