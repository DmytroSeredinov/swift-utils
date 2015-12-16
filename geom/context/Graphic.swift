import Cocoa
/**
 * set needsDisplay = true to clear the graphics
 * TODO: Write an example
 * NOTE: Example is in the Graphics class
 */
class Graphic:FlippedView,IGraphic{
    var fillShape:Shape = TempShape()
    var lineShape:Shape = Shape()//{get{return fillShape}set{fillShape = newValue}}/*Shape()*/
    var fillStyle:IFillStyle?;
    var lineStyle:ILineStyle?;
    var lineOffsetType:OffsetType;
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    init(_ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil, _ lineOffsetType:OffsetType = OffsetType()){
        Swift.print("Graphic.init()")
        self.fillStyle = fillStyle
        self.lineStyle = lineStyle
        self.lineOffsetType = lineOffsetType
        super.init(frame:NSRect(0,0,0,0))//<---move this into the arguments
        
        self.wantsLayer = true//this avoids calling drawLayer() and enables drawingRect()
        self.layer!.masksToBounds = false//this is needed!!!
        /*
        let layerA = CALayer()
        //layerA.bounds = CGRectMake(0, 0, 100, 100);//this doesnt matter
        layerA.frame = CGRectMake(20, 20, 300, 300);
        layerA.masksToBounds = false//finally it works
        //layerA.position = CGPointMake(10, 10);
        layerA.backgroundColor = NSColor.greenColor().CGColor
        layer!.addSublayer(layerA)
        */
        //layer?.masksToBounds = false
        fillShape.frame = CGRect(120,120,50,50);
        layer?.addSublayer(fillShape)
        fillShape.masksToBounds = false
        layer?.addSublayer(lineShape)
        lineShape.masksToBounds = false
        
        let layerD = CustomLayer(NSColor.blueColor())
        layerD.frame = CGRect(120,120,50,50);
        layerD.display()
        //layerD.masksToBounds = false
        layer!.addSublayer(layerD)
    }
    /*
    override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    
    }
    */
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
    /**
     *
     */
    /*
    override func drawRect(dirtyRect: NSRect) {
    Swift.print("Graphic.drawRect() ")
    super.drawRect(dirtyRect)
    }
    */
    
    /**
     * Convenince implicit setter
     */
    func setProperties(fillStyle:IFillStyle? = nil, lineStyle:ILineStyle? = nil){// :TODO: remove this and replace with setLineStyle and setFillStyle ?
        self.fillStyle = fillStyle;
        self.lineStyle = lineStyle;
    }
}
extension CGMutablePath{
    /**
     * Note its probably better to move this method into the Graphic class since then it can be overriden by subclasses, which you cant do with this extension method
     */
    func add(path:CGPath){
        CGPathAddPath(self, nil, path)
    }
}