import Foundation
/*
 * // :TODO: addItemsAt
 * // :TODO: removeAll
 * // :TODO: replaceItemAt
 * // :TODO: setNameAt
 * // :TODO: removeRange(range)
 */
class NodeModifier {
    /**
     * Removes the item @param index:Array in @param node
     */
    class func removeAt(inout node:Node, _ index:Array<Int>) -> Node {
        Swift.print("UNTESTED")
        if(index.count == 1 && node.children.count >= index[0]){return removeAt(&node, index[0])}/*the index is at its end point, cut of the branch*/
        else if(index.count > 1 && node.children.count >= index[0] && node.children[index[0]].children.count > 0){/*recursive*/
            node = removeAt(&node.children[index[0]],index.slice2(1,index.count))
        }
        return node
    }
    /**
     * Removes the item @param index in @param node
     */
    class func removeAt(inout node:Node, _ index:Int)->Node{
        return node.children.removeAtIndex(index)
    }
    /**
     *
     */
    class func removeAll(inout node:Node){
        
        
        func removeChildren(n:Node,_ parent:Node?,_ index:Int){
            if(n.children.count > 0){//branch, we never remove branches
                for var i = 0; i < n.children.count; ++i{
                    let child = n.children[i]
                    removeChildren(child,n,i)
                }
            }else if(parent != nil){//leaf, we only remove leafs
                parent?.children.removeAtIndex(index)
            }
        }
        
        removeChildren(node,nil, 0)
        //while
        
        
        
        
        //while(NodeParser.countAt(database, []) > 0) {removeAt(database, [0])}
    }
    /**
     * Adds @param child to @param node at @param index
     *
     */
    class func addAt(node:Node, _ index:Array<Int>, _ child:Node){
        NodeParser.nodeAt(node, index)?.add(child)
    }
    /**
     * Adds @param child to @param node
     */
    class func add(node:Node,_ child:Node){
        node.children.append(child)
    }
    /**
     * Add an item to the node
     * @Note: object syntax example: [title:"Birds"]
     * EXAMPLE: NodeModifier.addItemAt(database, [0,0], [title:"Peas"])
     */
    class func addDataAt(node:Node, _ index:Array<Int>, _ data:[String:AnyObject]) {
        NodeParser.nodeAt(node, index)?.data = data
    }
    /**
     *
     */
    class func addValueAt(node:Node, _ index:Array<Int>, _ key:String, _ value:AnyObject){
        NodeParser.nodeAt(node, index)?.data[key] = value
    }
}