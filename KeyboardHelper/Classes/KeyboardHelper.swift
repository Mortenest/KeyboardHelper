//
//  KeyboardHelper.swift
//  KeyboardHelper
//
//  Created by Timmi Trinks on 27/01/16.
//  Copyright © 2016 Nodes. All rights reserved.
//

import Foundation
import UIKit

/**
 Protocol `KeyboardNotificationDelegate` requires two functions.
 Function `keyboardWillAppear` and `keyboardWillDisappear` with parameter `info` struct `KeyboardAppearanceInfo`.
 */
public protocol KeyboardNotificationDelegate: class {
    
    /**
     This function will recongnize a change of `KeyboardAppearanceInfo` and will be fired when the keyboard will appaear.
     - Parameter info: Struct `KeyboardAppearanceInfo`.
     */
    func keyboardWillAppear(info: KeyboardAppearanceInfo)
    
    /**
     This function will recongnize a change of `KeyboardAppearanceInfo` and will be fired when the keyboard will disappaear.
     - Parameter info: Struct `KeyboardAppearanceInfo`.
     */
    func keyboardWillDisappear(info: KeyboardAppearanceInfo)
}

/**
 Useful helper to keep track of keyboard changes.
 */
public class KeyboardHelper {
    
    /**
     Delegate that conforms with the `KeyboardNotificationDelegate`.
     */
    public weak var delegate: KeyboardNotificationDelegate?
    
    /**
     Initialize the `delegate` and add the two observer for `keyboardWillAppear` and `keyboardWillDisappear`.
     Observers are nessecary for tracking the `UIKeyboardWillShowNotification` and `UIKeyboardWillHideNotification`, so the function that are connectet are getting fired.
     */
    required public init(delegate: KeyboardNotificationDelegate) {
        self.delegate = delegate
    }
    
    private init() {
        delegate = nil
    }
    
    public func registerForNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(KeyboardHelper.keyboardWillAppear(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(KeyboardHelper.keyboardWillDisappear(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    public func unregisterForNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    dynamic private func keyboardWillAppear(note: NSNotification) {
        let info = KeyboardAppearanceInfo(notification: note)
        self.delegate?.keyboardWillAppear(info)
    }
    
    dynamic private func keyboardWillDisappear(note: NSNotification) {
        let info = KeyboardAppearanceInfo(notification: note)
        self.delegate?.keyboardWillDisappear(info)
    }
    
    deinit {
        unregisterForNotifications()
    }
}
