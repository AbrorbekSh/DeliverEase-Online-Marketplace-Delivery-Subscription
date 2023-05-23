//
//  CoreDataService.swift
//  arbuz.kz
//
//  Created by Аброрбек on 23.05.2023.
//

import UIKit
import CoreData

final class CoreDataService {
    
    static private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static func makeRequest(completion: @escaping (([ProductCD]) -> Void )){
        let request : NSFetchRequest<ProductCD> = ProductCD.fetchRequest()
        do {
            let products = try context.fetch(request)
            completion(products)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    static func deleteProduct(product: ProductCD){
        context.delete(product)
        saveContext()
    }
    
    private static func saveContext(){
        do{
            try self.context.save()
        } catch {
            print("Error with \(error)")
        }
    }
}
