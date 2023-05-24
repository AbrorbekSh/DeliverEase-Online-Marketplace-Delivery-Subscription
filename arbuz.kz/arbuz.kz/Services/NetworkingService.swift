//
//  NetworkingService.swift
//  arbuz.kz
//
//  Created by Аброрбек on 22.05.2023.
//

import Foundation
import UIKit

final class NetworkingService {
    func fetchProducts() -> [Product]{
        return products
    }
    
    
    private let products = [banany, kiwi, kapusta_cvetnaya, apelsiny, apples, avokado, bios, dynya, iogurt_foodmaster, kartofel, laim, limon, luk_belyi, maslo, moloko_naturalnoe, morkov, iogurt_danone, perec_polugorkii_krasnyi, redis, snezhok, syr_lamber, syr_klub, tomaty, tvorog_emil, tvorog_prostokvashino]
    
    //Simulation :)
//    func configureImage(with url: String, completion: @escaping (UIImage) -> Void){
//        guard let url = URL(string: url) else {
//            return
//        }
//        let task = URLSession.shared.dataTask(with: url) {  data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//                let image = UIImage(data: data)
//                DispatchQueue.main.async{
//                    if let image = image {
//                        completion(image)
//                    }
//                }
//        }
//        task.resume()
//    }
}

final class Product: Hashable {
    let image: UIImage
    let name: String
    let price: Int
    let type: String
    let measure: String
    let availableAmount: Float
    var requiredAmount: Float = 0
    
    init(image: UIImage, name: String, price: Int, type: String, measure: String, availableAmount: Float){
        self.image = image
        self.name = name
        self.price = price
        self.type = type
        self.measure = measure
        self.availableAmount = availableAmount
    }
    
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == lhs.name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

let banany = Product(
    image: UIImage(named: "banany")!,
    name: "Бананы",
    price: 990,
    type: "Fruits",
    measure: "kg",
    availableAmount: 27
)

let kiwi = Product(
    image: UIImage(named: "kivi")!,
    name: "Киви",
    price: 1400,
    type: "Fruits",
    measure: "kg",
    availableAmount: 10
)

let kapusta_cvetnaya = Product(
    image: UIImage(named: "kapusta_cvetnaya")!,
    name: "Капуста цветная",
    price: 340,
    type: "Fruits",
    measure: "kg",
    availableAmount: 27
)

let apelsiny = Product (
    image: UIImage(named: "apelsiny")!,
    name: "Апельсины Египет кг",
    price: 1270,
    type: "Fruits",
    measure: "kg",
    availableAmount: 10
)

let apples = Product (
    image: UIImage(named: "apples")!,
    name: "Яблоко Белый налив кг",
    price: 1560,
    type: "Fruits",
    measure: "kg",
    availableAmount: 10
)
let avokado = Product (
    image: UIImage(named: "avokado")!,
    name: "Авокадо Pinkerton шт",
    price: 975,
    type: "Fruits",
    measure: "sht",
    availableAmount: 10
)
let baklazhany = Product (
    image: UIImage(named: "baklazhany_kazahstan")!,
    name: "Баклажаны Казахстан кг",
    price: 1170,
    type: "Vegetables",
    measure: "kg",
    availableAmount: 10
)
let bios = Product (
    image: UIImage(named: "bios")!,
    name: "Био-с Фуд Мастер т/п 500 мл",
    price: 450,
    type: "Milk",
    measure: "sht",
    availableAmount: 10
)
let dynya = Product (
    image: UIImage(named: "dynya")!,
    name: "Дыня Хани Дью",
    price: 6660,
    type: "Fruits",
    measure: "kg",
    availableAmount: 10
)
let kapusta_belokochannaya = Product (
    image: UIImage(named: "kapusta_belokochannaya")!,
    name: "Капуста белокочанная молодая",
    price: 435,
    type: "Vegetables",
    measure: "kg",
    availableAmount: 10
)
let iogurt_foodmaster = Product (
    image: UIImage(named: "iogurt_foodmaster")!,
    name: "Йогурт FoodMaster",
    price: 330,
    type: "Milk",
    measure: "sht",
    availableAmount: 10
)

let kartofel = Product (
    image: UIImage(named: "kartofel")!,
    name: "Картофель молодой Казахстан кг",
    price: 500,
    type: "Vegetables",
    measure: "kg",
    availableAmount: 10
)

let laim = Product (
    image: UIImage(named: "laim")!,
    name: "Лайм шт",
    price: 280,
    type: "Fruits",
    measure: "sht",
    availableAmount: 10
)

let limon = Product (
    image: UIImage(named: "limon")!,
    name: "Лимон Аргентина шт",
    price: 240,
    type: "Fruits",
    measure: "sht",
    availableAmount: 10
)

let luk_belyi = Product(
    image: UIImage(named: "luk_belyi")!,
    name: "Лук белый Казахстан кг",
    price: 1820,
    type: "Vegetables",
    measure: "kg",
    availableAmount: 27
)

let mandariny_maroko = Product(
    image: UIImage(named: "mandariny_marokko")!,
    name: "Мандарины Марокко кг",
    price: 1820,
    type: "Fruits",
    measure: "kg",
    availableAmount: 27
)

let maslo = Product(
    image: UIImage(named: "maslo")!,
    name: "Масло сливочное",
    price: 1105,
    type: "Milk",
    measure: "sht",
    availableAmount: 27
)

let moloko_naturalnoe = Product(
    image: UIImage(named: "moloko_naturalnoe")!,
    name: "Молоко живое 2,5%",
    price: 650,
    type: "Milk",
    measure: "sht",
    availableAmount: 27
)

let morkov = Product(
    image: UIImage(named: "morkov")!,
    name: "Морковь Казахстан кг",
    price: 395,
    type: "Vegetables",
    measure: "kg",
    availableAmount: 27
)


let ogurcy = Product(
    image: UIImage(named: "ogurcy")!,
    name: "Огурцы Рава кг",
    price: 410,
    type: "Vegetables",
    measure: "kg",
    availableAmount: 27
)

let iogurt_danone = Product(
    image: UIImage(named: "ogurt_danone")!,
    name: "Йогурт Активиа",
    price: 240,
    type: "Milk",
    measure: "sht",
    availableAmount: 27
)

let perec_polugorkii_krasnyi = Product(
    image: UIImage(named: "perec_polugorkii_krasnyi")!,
    name: "Перец полугорький красный кг",
    price: 1925,
    type: "Vegetables",
    measure: "kg",
    availableAmount: 27
)

let redis = Product(
    image: UIImage(named: "redis")!,
    name: "Редис кг",
    price: 665,
    type: "Vegetables",
    measure: "kg",
    availableAmount: 27
)

let snezhok = Product(
    image: UIImage(named: "snezhok")!,
    name: "Фуд Мастер снежок 2%",
    price: 420,
    type: "Milk",
    measure: "sht",
    availableAmount: 27
)

let syr_lamber = Product(
    image: UIImage(named: "syr_lamber")!,
    name: "Сыр Ламбер полутвердый",
    price: 6850,
    type: "Milk",
    measure: "kg",
    availableAmount: 27
)


let syr_klub = Product(
    image: UIImage(named: "syr_klub")!,
    name: "Сыр полутвёрдый витязь",
    price: 6270,
    type: "Milk",
    measure: "kg",
    availableAmount: 27
)

let tomaty = Product(
    image: UIImage(named: "tomaty")!,
    name: "Томаты бриоза оранжевые кг",
    price: 2995,
    type: "Vegetables",
    measure: "kg",
    availableAmount: 27
)

let tvorog_emil = Product(
    image: UIImage(named: "tvorog_emil")!,
    name: "Творог Эмиль 5% 380 г",
    price: 1295,
    type: "Milk",
    measure: "sht",
    availableAmount: 27
)

let tvorog_prostokvashino = Product(
    image: UIImage(named: "tvorog_prostokvashino")!,
    name: "Творог Простоквашино 2% ",
    price: 1040,
    type: "Milk",
    measure: "sht",
    availableAmount: 27
)
