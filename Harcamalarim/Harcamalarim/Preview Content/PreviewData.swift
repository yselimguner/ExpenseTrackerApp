//
//  PreviewData.swift
//  Harcamalarim
//
//  Created by iOS PSI on 1.11.2022.
//

import Foundation
import SwiftUI

var transactionPreviewData = Transaction(id: 1, date: "01/11/2022", institution: "PsiGaming", account: "Visa PsiGaming", merchant: "Cigarette", amount: 32.00, type: "debit", categoryId: 001, category: "Product", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
