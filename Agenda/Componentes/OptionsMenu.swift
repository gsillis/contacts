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
    case call
    case maps
}
class OptionsMenu: NSObject {

    func optionsMenu(completion: @escaping(_ option: OptionsMenuActionSheet) ->Void) -> UIAlertController {
        let menu = UIAlertController(title: "Atenção", message: "Escolha uma das opções abaixo", preferredStyle: .actionSheet)
        let sms = UIAlertAction(title: "Enviar sms", style: .default) { action in
            completion(.sms)
        }
        menu.addAction(sms)
        let call = UIAlertAction(title: "Ligar", style: .default) { action in
            completion(.call)
        }
        menu.addAction(call)
        let maps = UIAlertAction(title: "Abrir no maps", style: .default) { action in
            completion(.maps)
        }
        menu.addAction(maps)
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        menu.addAction(cancel)
        return menu
    }
}
