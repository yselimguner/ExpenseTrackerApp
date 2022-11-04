//
//  TransactionsList.swift
//  Harcamalarim
//
//  Created by iOS PSI on 2.11.2022.
//

import SwiftUI

struct TransactionsList: View {
    @EnvironmentObject var TransactionsListVM:TransactionListViewModel
    var body: some View {
        VStack{
            List{
                //Harcamaların Gruplandırışması
                ForEach(Array(TransactionsListVM.groupTransactionsByMonth()),id:\.key ){ month, transactions in
                    Section{
                        //Harcamalarım Listesi
                        ForEach(transactions){ transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } header: {
                        //Harcamalarım Ayı
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Harcamalar")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionsList_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            TransactionsList()
            TransactionsList()
        }
    }
}
