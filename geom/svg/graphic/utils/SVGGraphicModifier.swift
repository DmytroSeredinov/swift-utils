import Cocoa

class SVGGraphicModifier {
    /**
    * Applies the @param strokeStyle to the @param graphics
    * @Note: If @param strokeStyle Does not have a variable, the default flash variable is applied
    * @NOTE: For example, a miter limit of 1.414 converts miters to bevels for theta less than 90 degrees, a limit of 4.0 converts them for theta less than approximately 29 degrees, and a limit of 10.0 converts them for theta less than approximately 11.5 degrees.
    * @NOTE: miterLength / stroke-width = 1 / sin ( theta / 2 ) The ratio of miter length (distance between the outer tip and the inner corner of the miter) to stroke-width is directly related to the angle (theta) between the segments in user space by the formula:
     * @NOTE: miterlimit The limit on the ratio of the miter length to the stroke-width. The value of <miterlimit> must be a <number> greater than or equal to 1.
    */
    class func applyStrokeStyle(graphics:Graphics, _ style:SVGStyle) {
        let strokeWidth:CGFloat = 
        let strokeMiterLimit:CGFloat = SVGStyleUtils.miterLimit(style.strokeMiterLimit)
        let strokeLineCap:CGLineCap = SVGStyleUtils.lineCap(style.strokeLineCap)
        let strokeLineJoin:CGLineJoin = SVGStyleUtils.lineJoin(style.strokeLineJoin)
        /*color*/
        //Swift.print("style.stroke: " + "\(style.stroke)")
        let colorVal:Double = !(style.stroke.isNaN) ? style.stroke : Double(0x000000)
        //Swift.print("colorVal: " + "\(colorVal)")
        Swift.print("style.strokeOpacity: " + "\(style.strokeOpacity)")
        let strokeOpacity:CGFloat = !(style.strokeOpacity.isNaN) ? style.strokeOpacity : 1;
        Swift.print("strokeOpacity: " + "\(strokeOpacity)")
        let color:NSColor = NSColorParser.nsColor(UInt(colorVal), strokeOpacity)
        graphics.line(strokeWidth, color, strokeLineCap, strokeLineJoin, strokeMiterLimit)
    }
}

private class Utils{
    
}