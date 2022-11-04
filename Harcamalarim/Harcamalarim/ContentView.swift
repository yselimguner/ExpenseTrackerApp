//
//  ContentView.swift
//  Harcamalarim
//
//  Created by iOS PSI on 1.11.2022.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListsVM:TransactionListViewModel
    //var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 24){
                    //Başlık kısmı
                    Text("Harcamalarım")
                        .font(.title2)
                        .bold()
                    
                    //Tablo Görünümü
                    let data = transactionListsVM.accumulateTransactions()
                    if !data.isEmpty{
                        let totalExpenses = data.last?.1 ?? 0
                        CardView {
                            VStack(alignment: .leading){
                                ChartLabel(totalExpenses.formatted(.currency(code: "TRY")),type: .title, format: "$%.02f")
                                LineChart()
                            }.background(Color.systemBackground)
                        }.data(data)
                            .chartStyle(ChartStyle(backgroundColor: .white,
                                               foregroundColor: ColorGradient(.blue, .purple))).frame(height: 250)
                    }
                    
                    //Harcama Listesi
                    RecentTransactionList()
                }.padding()
                    .frame(maxWidth:.infinity)
            }.background(Color.background)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    //Notification Icon
                    ToolbarItem{
                        Image(systemName: "bell.badge")
                            .renderingMode(.original)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.icon, .primary)
                    }
                }
        }.navigationViewStyle(.stack)
            .accentColor(.primary)
    }
    
}

    struct ContentView_Previews: PreviewProvider {
        static let transactionListVM : TransactionListViewModel = {
            let transactionListVM = TransactionListViewModel()
            transactionListVM.transactions = transactionListPreviewData
            return transactionListVM
        }()
        static var previews: some View {Group{
            ContentView()
            ContentView().preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
        }
    }
