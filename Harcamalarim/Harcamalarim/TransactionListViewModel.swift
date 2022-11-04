//
//  TransactionListViewModel.swift
//  Harcamalarim
//
//  Created by iOS PSI on 1.11.2022.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String,Double)]

final class TransactionListViewModel:ObservableObject{
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getTransactions()
    }
    
    func getTransactions(){
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else{
            print(" JSON VERİSİ SORUNLU ")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data,response) -> Data in
                guard let  httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print("Aktarım başarısız oldu", error.localizedDescription)
                case .finished:
                    print("Aktarım sağlandı")
                }
            } receiveValue: { result in
                self.transactions = result
                dump(self.transactions)
            }
            .store(in: &cancellables)
    }
    
    func groupTransactionsByMonth()-> TransactionGroup{
        guard !transactions.isEmpty else {
            return [:]
        }
        let groupedTransactions = TransactionGroup(grouping: transactions) { $0.month}
        return groupedTransactions
    }
    
    func accumulateTransactions() -> TransactionPrefixSum{
        print("Accumulate Transactions")
        guard !transactions.isEmpty else{return []}
        
        let today = "10/04/2022".dateParsed() // Tarih ayarlanması
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print("dateInterval", dateInterval)
        
        
        var sum:Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24){
            let dailyExpenses = transactions.filter{ $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount}
            
            sum = sum+dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "dailyTotal", dailyTotal, "sum:", sum)
        }
        return cumulativeSum
    }
    
}
