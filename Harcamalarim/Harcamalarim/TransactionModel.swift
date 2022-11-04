//
//  TransactionModel.swift
//  Harcamalarim
//
//  Created by iOS PSI on 1.11.2022.
//

import Foundation
import SwiftUIFontIcon


struct Transaction:Identifiable,Decodable, Hashable{
    let id:Int
    let date:String
    let institution:String
    let account:String
    var merchant:String
    let amount:Double
    let type:TransactionType.RawValue
    let categoryId:Int
    var category:String
    var isPending:Bool
    var isTransfer:Bool
    var isExpense:Bool
    var isEdited:Bool
    
    var icon:FontAwesomeCode{
        if let category = Category.all.first(where: {$0.id == categoryId}){
            return category.icon
        }
        return .question
    }
    
    var dateParsed:Date{
        date.dateParsed()
    }
    
    var signedAmount:Double{
        return type == TransactionType.credit.rawValue ? amount : -amount
    }
    
    var month:String{
        dateParsed.formatted(.dateTime.year().month(.wide))
    }
}

enum TransactionType:String{
    case debit = "debit"
    case credit = "credit"
}

struct Category{
    let id:Int
    let name:String
    let icon:FontAwesomeCode
    var mainCategoryId:Int?
}

extension Category{
    static let autoAndTransport = Category(id: 1, name: "Auto & Transport", icon: .car_alt)
    static let billsAndUtilities = Category(id: 2, name: "Bills & Utililites", icon: .file_invoice_dollar)
    
    
    static let publicTransportation = Category(id: 101, name: "Public Transportation", icon: .bus, mainCategoryId: 1)
    static let taxi = Category(id: 102, name: "Taxi", icon: .taxi, mainCategoryId: 1)
}

extension Category{
    static let categories:[Category] = [
        .autoAndTransport,
        .billsAndUtilities
    ]
    
    static let subCategories :[Category] = [
        .publicTransportation,
        .taxi]
    
    static let all:[Category] = categories + subCategories
}
