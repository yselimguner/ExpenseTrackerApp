//
//  HarcamalarimSatiri.swift
//  Harcamalarim
//
//  Created by iOS PSI on 1.11.2022.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var transaction : Transaction
    
    var body: some View {
        HStack(spacing: 20){
            //Kategori Icon'u ayarlamak
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width:44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: Color.icon)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                //Tüccar işlemi
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                //İşlem Kategorisi
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                //İşlem tarihi
                Text(transaction.dateParsed,format: .dateTime.year().day().month())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
                Spacer()
                //işlem Fiyatı
                Text(transaction.signedAmount, format: .currency(code: "TRY"))
                    .bold()
                    .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.text : .primary)
                
            }
            
            .padding([.top, .bottom],8)
        }
    }
    
    struct HarcamalarimSatiri_Previews: PreviewProvider {
        static var previews: some View {
            TransactionRow(transaction: transactionPreviewData)
            TransactionRow(transaction: transactionPreviewData).preferredColorScheme(.dark)
        }
    }

