import Foundation

class FlexBoxModifier{
    /**
     * TODO: Possibly use FlexItem here that decorates something
     */
    static func justifyContent<T:IPositional>(_ items:[T], _ type:FlexBoxType.Justify, _ container:CGRect) where T:ISizeable{
        switch type{
            case .flexStart:
                //Swift.print("flexStart")
                JustifyUtils.justifyFlexStart(items,container)
            case .flexEnd:
                //Swift.print("flexEnd")
                JustifyUtils.justifyFlexEnd(items, container)
            case .center:
                //Swift.print("center")
                JustifyUtils.center(items,container)
            case .spacebetween:
                Swift.print("spacebetween")
            case .spaceAround:
                Swift.print("spaceAround")
        }
    }
}
class JustifyUtils{
    /**
     * Aligns from start to end
     */
    static func justifyFlexStart<T:IPositional>(_ items:[T], _ container:CGRect) where T:ISizeable{
        var x:CGFloat = container.x//interim x
        items.forEach{ item in
            item.x = x
            x += item.width
        }
    }
    /**
     * Aligns from end to start
     */
    static func justifyFlexEnd<T:IPositional>(_ items:[T], _ container:CGRect) where T:ISizeable{
        var x:CGFloat = container.width/*interim x*/
        items.reversed().forEach{ item in/*Move backwards*/
            x -= item.width
            item.x = x
        }
    }
    /**
     * Aligns one item after the other and centers their total position
     */
    static func center<T:IPositional>(_ items:[T], _ container:CGRect) where T:ISizeable{
        //find the totalW of all items
        let totW:CGFloat = items.reduce(0){$0 + $1.size.width}
        //Use Align.center to find x
        let p:CGPoint = Align.alignmentPoint(CGSize(totW,0), container.size, Alignment.centerCenter, Alignment.centerCenter, CGPoint())
        //create new Rect
        let newRect = CGRect(p.x,container.y,container.width,container.height)
        //Use justifyFlexStart and lay items out left to right with new rect as offset
        justifyFlexStart(items, newRect)
    }
}
