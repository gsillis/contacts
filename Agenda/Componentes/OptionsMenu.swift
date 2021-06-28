//
//  OptionsMenu.swift
//  Agenda
//
//  Created by Gabriela Sillis on 28/06/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

class OptionsMenu: NSObject {

    func optionsMenu() -> UIAlertController {
        let menu = UIAlertController(title: "Atenção", message: "Escolha uma das opções abaixo", preferredStyle: .actionSheet)
        let sms = UIAlertAction(title: "Enviar sms", style: .default) { acao in
            //implementar
        }
        menu.addAction(sms)
        return menu
    }
}
