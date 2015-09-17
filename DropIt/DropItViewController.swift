//
//  DropItViewController.swift
//  DropIt
//
//  Created by Seth on 7/6/15.
//  Copyright (c) 2015 Seth. All rights reserved.
//

import UIKit

class DropItViewController: UIViewController, UIDynamicAnimatorDelegate
{
    @IBOutlet weak var gameView: BezierPathsView!
    
        
    // Lazy Instantiation
    lazy var animator: UIDynamicAnimator = {
       let lazilyCreatedDynamicAnimator = UIDynamicAnimator (referenceView: self.gameView)
        lazilyCreatedDynamicAnimator.delegate = self
        return lazilyCreatedDynamicAnimator
    }()
    
    let dropitBehavior = DropITBehavior
    
    var attachment: UIAttachmentBehavior? {
        willSet {
            animator.removeBehavior(attachment)
            gameView.setPath(nil, named: PathNames.Attachment)

        }
        didSet {
            if attachment != nil {
                animator.addBehavior(attachment)
                attachment?.action = { [unowned self] in
                    if let attachedView = self.attachment?.items.first as? UIView {
                        let path = UIBezierPath()
                        path.moveToPoint(self.attachment!.anchorPoint)
                        path.addLineToPoint(attachedView.center)
                        self.gameView.setPath(path, named: PathNames.Attachment)
                    }
                }
            }
        }
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(dropitBehavior)
       
    }
    
    var dropsPerRow = 10
    
    var dropSize: CGSize {
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
    
    
    @IBAction func drop(sender: UITapGestureRecognizer) {
        
        drop()
    }
    
    func drop() {
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
    
    
        let dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.random
    
        gameView.addSubview(dropView)
        
//        gravity.addItem(dropView)
//        collider.addItem(dropView)
    }

}


//Mark Class Extensions
private extension CGFloat {
        static func random(max: Int) -> CGFloat {
            return CGFloat(arc4random() % UInt32(max))
        }
    }
private extension UIColor {
    class var random: UIColor {
        switch arc4random() % 5 {
            case 0: return UIColor.greenColor()
            case 1: return UIColor.blueColor()
            case 2: return UIColor.orangeColor()
            case 3: return UIColor.redColor()
            case 4: return UIColor.purpleColor()
            default: return UIColor.blackColor()
    
            }
    
        }

    }



