//
//  CalculateAverage.swift
//  Agenda
//
//  Created by Gabriela Sillis on 28/06/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import Foundation

class calculateAverage: NSObject {
    func calculateAverage(contacts: Array<Contact>, success: @escaping(_ average:Dictionary<String, Any>) -> Void, failure: @escaping(_ error: Error) ->Void) {
        
        guard let url = URL(string: "https://www.caelum.com.br/mobile") else { return }
        var contactList: Array<Dictionary<String, Any>> = []
        var json:Dictionary<String, Any> = [:]
        
        for contact in contacts {
            guard let name = contact.name else { break }
            guard let phone = contact.phone else { break }
            guard let address = contact.address else { break }
            guard let site = contact.site else { return}
            
            let contactDictionary = [
                "id": "\(contact.objectID)",
                "nome": name,
                "endereo": address,
                "telefone":phone,
                "site": site,
                "nota": String(contact.nota)
            ]
            contactList.append(contactDictionary as [String:Any])
        }
        
        json = [
            "list": [
                "aluno": contactList
            ]
        ]
        
        do {
            var request = URLRequest(url: url)
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            request.httpBody = data
            request.httpMethod = "POST"
            request.addValue("aplication/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil {
                    do {
                        let dictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String,Any>
                        success(dictionary)
                    } catch {
                        failure(error)
                    }
                }
            })
            task.resume()
        } catch {
            print(error.localizedDescription)
        }
    }
}
