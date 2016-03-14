import Cocoa

class TextFieldModifier {
    /**
     *
     */
    class func applyTextFormat(textField:TextField,_ textFormat:TextFormat){
        textField.selectable = textFormat.selectable
        textField.drawsBackground = textFormat.background
        textField.backgroundColor = textFormat.backgroundColor

        textField.alignment = Utils.alignment(textFormat.align)//Left,Right,Justified,Natural,Center
        textField.textColor = textFormat.color
        textField.font = Utils.font(textFormat.font,textFormat.size)
        textField.editable = textFormat.type == "input"
        textField.focusRingType = NSFocusRingType.None//<- implement suport for this if needed, Personally i dont like it. You can use the focus state instead and have your own focus style applied
        textField.bordered = textFormat.border//<--maybe implement later
        //textField.maximumNumberOfLines = 1//<---cant get these to work yet
        textField.usesSingleLineMode = !textFormat.multiline//<---cant get these to work yet, works now in multiline textfields
        //textField.lineBreakMode = .ByWordWrapping
        //Swift.print("textFormat.wordWrap: " + "\(textFormat.wordWrap)")
        textField.cell?.wraps = textFormat.wordWrap//wordwrap enables the text to be in one line basically
        //if(textFormat.multiline) {textField.setContentCompressionResistancePriority(50, forOrientation: .Horizontal)}//this is for auto-layout only i think

        textField.cell?.scrollable = textFormat.scrollable//i guess this is connected to wordWrap
        
        
    }
    /**
     * Beta
     */
    class func size(textField:TextField,_ width:CGFloat,_ height:CGFloat) {
        textField.frame.width = width;/*SkinParser.width(this);*/
        textField.frame.height = height;/*SkinParser.height(this);*/
        //textField.setTextFormat(StylePropertyParser.textFormat(this));
    }
}
private class Utils{
    /**
     *
     */
    class func font(fontName:String,_ size:CGFloat) -> NSFont{
        let fontDescriptor:NSFontDescriptor = NSFontDescriptor(fontAttributes: [NSFontNameAttribute:fontName])//NSForegroundColorAttributeName:NSColor.redColor(),
        let font = NSFont(descriptor: fontDescriptor, size: size)
        
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = (10.0)
        paragraphStyle.alignment
        
        
        /*public var lineSpacing: CGFloat
        public var paragraphSpacing: CGFloat
        public var alignment: NSTextAlignment
        public var firstLineHeadIndent: CGFloat
        public var headIndent: CGFloat
        public var tailIndent: CGFloat
        public var lineBreakMode: NSLineBreakMode
        public var minimumLineHeight: CGFloat
        public var maximumLineHeight: CGFloat
        public var baseWritingDirection: NSWritingDirection
        public var lineHeightMultiple: CGFloat
        public var paragraphSpacingBefore: CGFloat*/
        
        /*
        NSFont *fontBolded = [NSFont fontWithName:@"Baskerville Bold" size:12.0f];
        NSMutableParagraphStyle *paragStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [paragStyle setAlignment:NSCenterTextAlignment];
        NSDictionary *dictBoldAttr = [NSDictionary dictionaryWithObjectsAndKeys:
        fontBolded, NSFontAttributeName,
        paragStyle, NSParagraphStyleAttributeName,
        nil];
        
        */
        
        
        
        return font!
    }
    /**
     *
     */
    class func alignment(alignType:String) -> NSTextAlignment{
        let align:NSTextAlignment
        if(alignType == "left"){align = NSTextAlignment.Left}
        else if(alignType == "right"){align = NSTextAlignment.Right}
        else if(alignType == "center"){align = NSTextAlignment.Center}
        else if(alignType == "justified"){align = NSTextAlignment.Justified}
        else if(alignType == "natural"){align = NSTextAlignment.Natural}
        else {fatalError("ALIGN TYPE NOT SUPPORTED: " + alignType)}
        return align
    }
}