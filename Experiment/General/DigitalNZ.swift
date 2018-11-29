//
//  DigitalNZ.swift
//  DigitalNZ
//
//  Created by Michael NLNZ on 9/03/18.
//  Copyright © 2018 Digital New Zealand. All rights reserved.
//

import Foundation

class DigitalNZ {
    
    let apiKey = "iaStyqKuqiBjgS7J6Td5"
    
    func item(id: Int) -> NLNZItem {
        let url = "https://api.digitalnz.org/v3/records/\(id).json?api_key=\(apiKey)"
        let item = NLNZItem()
        item.id = id
        return item
    }
    
    func collection(_ collectionName: String) -> NLNZCollection {
        let collection = NLNZCollection()
        collection.title = collectionName
        let url = "https://api.digitalnz.org/v3/records.json?api_key=\(apiKey)&facets=year,usage,collection,category&per_page=0&facets_per_page=500&and[content_partner][]=#{URI.escape(content_partner)}"
        return collection
    }

//    func allCollections() -> [NLNZCollection] {
//        var collections = [NLNZCollection]()
//        let url = "https://api.digitalnz.org/v3/records.json?api_key=\(apiKey)&facets=content_partner&per_page=0&facets_per_page=500"
//        let response = parseAPIRequest(query: url)
//        let search = response["search"] as! [String:Any]
//        for facet in search["facets"] as! [String:Any] {
//            let coll          = collection(facet.key)
//            coll.itemCount    = facet.value as! Int
//            collections.append(coll)
//        }
//        return collections
//    }
//
    func organisation(_ organisationName: String) -> NLNZOrganisation {
        let organisation = NLNZOrganisation()
        organisation.title = organisationName
        return organisation
    }
    
    func allOrganisations() -> [NLNZOrganisation] {
        var organisations = [NLNZOrganisation]()
        let orgs = readDataFromFile(file: "content-partners")
        let orgData = csv(data: orgs!)
        for org in orgData {
            if org.count == 6 {
                let newOrg = NLNZOrganisation()
                newOrg.title        = org[0]
                newOrg.category     = org[1]
                newOrg.country      = org[2]
                newOrg.itemCount    = Int(org[3])!
                organisations.append(newOrg)
            }
        }
        return organisations
    }
    
    func allSites() -> [NLNZSite] {
        let sites = [NLNZSite]()
        return sites
    }
    
    func site(_ siteName: String) -> NLNZSite {
        let site = NLNZSite()
        return site
    }

    func parseAPIRequest(query: String, completion: @escaping (_ result: [String: Any]) -> Void) {
        URLSession.shared.dataTask(with: URL(string: query)!) { (data, res, err) in
            if let d = data {
                if let value = String(data: d, encoding: String.Encoding.utf8) {
                    if let jsonData = value.data(using: String.Encoding.utf8) {
                        do {
                            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                            completion(json)
                        } catch {
                            NSLog("ERROR \(error.localizedDescription)")
                        }
                    }
                }
            }
        }.resume()
    }
    
    func readDataFromFile(file: String) -> String!{
        guard let filePath = Bundle.main.path(forResource: file, ofType: ".csv")
            else {
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filePath, encoding: .utf8)
            return contents
        } catch {
            print("File Read Error for file \(filePath)")
            return nil
        }
    }
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: "\t")
            result.append(columns)
        }
        return result
    }

    
}
