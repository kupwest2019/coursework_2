


import UIKit

public class Test1 : NSObject {
    
    //// Drawing Methods
    
    @objc dynamic public class func drawCanvas1(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 214, height: 131), resizing: ResizingBehavior = .aspectFit, innerProgress: CGFloat = 0) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 214, height: 131), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 214, y: resizedFrame.height / 131)
        
        
        //// Color Declarations
        let colorFail = UIColor(red: 0.963, green: 0.004, blue: 0.004, alpha: 1.000)
        let colorFail2 = UIColor(red: 0.574, green: 0.000, blue: 0.000, alpha: 1.000)
        let normal = UIColor(red: 1.000, green: 0.877, blue: 0.971, alpha: 1.000)
        
        //// Gradient Declarations
        let gradientFail = CGGradient(colorsSpace: nil, colors: [colorFail.cgColor, colorFail2.cgColor] as CFArray, locations: [0, 1])!
        
        //// Variable Declarations
        let expression: CGFloat = innerProgress * 218
        
        //// Group
        //// outside Drawing
        let outsidePath = UIBezierPath(ovalIn: CGRect(x: 57, y: 15, width: 95, height: 95))
        context.saveGState()
        outsidePath.addClip()
        context.drawLinearGradient(gradientFail, start: CGPoint(x: 104.5, y: 15), end: CGPoint(x: 104.5, y: 110), options: [])
        context.restoreGState()
        UIColor.black.setStroke()
        outsidePath.lineWidth = 1
        outsidePath.stroke()
        
        
        //// inside Drawing
        let insidePath = UIBezierPath(ovalIn: CGRect(x: 79, y: 36, width: 52, height: 52))
        normal.setFill()
        insidePath.fill()
        UIColor.black.setStroke()
        insidePath.lineWidth = 1
        insidePath.stroke()
        
        
        
        
        //// Mask Drawing
        let maskPath = UIBezierPath()
        maskPath.move(to: CGPoint(x: 141, y: 62))
        maskPath.addCurve(to: CGPoint(x: 105, y: 98), controlPoint1: CGPoint(x: 141, y: 81.88), controlPoint2: CGPoint(x: 124.88, y: 98))
        maskPath.addCurve(to: CGPoint(x: 69, y: 62), controlPoint1: CGPoint(x: 85.12, y: 98), controlPoint2: CGPoint(x: 69, y: 81.88))
        maskPath.addCurve(to: CGPoint(x: 105, y: 26), controlPoint1: CGPoint(x: 69, y: 42.12), controlPoint2: CGPoint(x: 85.12, y: 26))
        maskPath.addCurve(to: CGPoint(x: 141, y: 62), controlPoint1: CGPoint(x: 124.88, y: 26), controlPoint2: CGPoint(x: 141, y: 42.12))
        maskPath.close()
        UIColor.black.setStroke()
        maskPath.lineWidth = 21
        context.saveGState()
        context.setLineDash(phase: 0, lengths: [expression, 225])
        maskPath.stroke()
        context.restoreGState()
        
        context.restoreGState()
        
    }
    
    
    
    
    @objc(Test1ResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.
        
        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }
            
            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
            case .aspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .aspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .stretch:
                break
            case .center:
                scales.width = 1
                scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
