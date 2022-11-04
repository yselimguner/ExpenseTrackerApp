//
//  SonHarcamalarListesi.swift
//  Harcamalarim
//
//  Created by iOS PSI on 2.11.2022.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionistVM :TransactionListViewModel
    
    var body: some View {
        VStack{
            HStack{
                //Başlık
                Text("Son Harcamalarım")
                    .bold()
                Spacer()
                //Başlık Link
                NavigationLink{
                    TransactionsList()
                } label: {
                    HStack(spacing:4){
                        Text("Hepsini Gör")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding(.top)
            //Son Harcamalarım Listesi
            ForEach(Array(transactionistVM.transactions.prefix(5).enumerated()), id:\.element){index, transaction in
                TransactionRow(transaction: transaction)
                
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
            
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20,style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y:5)
    }
}

struct SonHarcamalarListesi_Previews: PreviewProvider {
    static let transactionListVM : TransactionListViewModel = {
       let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        Group{
            RecentTransactionList()
            RecentTransactionList()
                .preferredColorScheme(ColorScheme.dark)
        }
            .environmentObject(transactionListVM)
    }
}
