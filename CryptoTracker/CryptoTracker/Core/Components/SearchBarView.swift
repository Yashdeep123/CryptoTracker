//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Yash Patil on 25/08/22.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText : String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? Color.theme.secondaryText
                    : Color.theme.accentColor)
        
                TextField("Search by name or Symbol...", text: $searchText)
                    .foregroundColor(Color.theme.accentColor)
                
            Image(systemName: "xmark.circle.fill")
                .padding(.trailing,5)
                .offset(x:10)
                .foregroundColor(Color.theme.accentColor)
                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                    searchText = ""
                }
            /*.overlay(alignment:.trailing)
               {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundColor(Color.theme.accentColor)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                }
                .disableAutocorrection(true)*/
                
        }
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.theme.backgroundText)
            .shadow(color: Color.theme.accentColor.opacity(0.35), radius: 5, x: 0, y: 0)
        ).padding(.horizontal)
        
        
        
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.dark)
        }
    }
}
