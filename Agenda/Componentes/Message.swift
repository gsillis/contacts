//
//  Message.swift
//  Agenda
//
//  Created by Gabriela Sillis on 28/06/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import MessageUI

class Message: NSObject {
    
    func configSms(_ contact: Contact) -> MFMessageComposeViewController? {
        
        if MFMessageComposeViewController.canSendText() {
            let messageComponent  = MFMessageComposeViewController()
            guard let contact = contact.phone else { return messageComponent }
            
            messageComponent.recipients = [contact]
            messageComponent.messageComposeDelegate = self
            
            return messageComponent
        }
        return nil
    }
}

//MARK: - extension MFMessageComposeViewControllerDelegate
extension Message: MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
