//
//  CurrencyRequest.swift
//  currency-converter
//
//  Created by Gabriel Tavares on 30/04/20.
//  Copyright © 2020 Gabriel Tavares. All rights reserved.
//

import Foundation

enum CurrencyError:Error {
    case noData
    case canNotProcessData
}

struct CurrencyRequest {
    
    let access_key = "d24be64c3fa5c57fe52fa6310df05340"
    
    func getCurrencies(completion: @escaping(Result<Currencies, CurrencyError>) -> Void) {
        let urlString = "http://api.currencylayer.com/list?access_key=\(access_key)"
        let url = URL(string: urlString)!
        let request = URLSession.shared.dataTask(with: url) {data, _, _ in
            guard let json = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let currenciesResponse = try decoder.decode(Currencies.self, from: json)
                completion(.success(currenciesResponse))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        request.resume()
    }
    
    func getRates(completion: @escaping(Result<Rates, CurrencyError>) -> Void) {
        let urlString = "http://api.currencylayer.com/live?access_key=\(access_key)"
        let url = URL(string: urlString)!
        let request = URLSession.shared.dataTask(with: url) {data, _, _ in
            guard let json = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let ratesResponse = try decoder.decode(Rates.self, from: json)
                completion(.success(ratesResponse))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        request.resume()
    }
}
