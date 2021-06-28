//
//  OptionsMenu.swift
//  Agenda
//
//  Created by Gabriela Sillis on 28/06/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

enum OptionsMenuActionSheet {
    case sms
}
class OptionsMenu: NSObject {

    func optionsMenu(completion: @escaping(_ option: OptionsMenuActionSheet) ->Void) -> UIAlertController {
        let menu = UIAlertController(title: "Atenção", message: "Escolha uma das opções abaixo", preferredStyle: .actionSheet)
        let sms = UIAlertAction(title: "Enviar sms", style: .default) { acao in
            completion(.sms)
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        menu.addAction(sms)
        menu.addAction(cancel)
        return menu
    }
}
