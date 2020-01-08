//
//  NotificationListViewRow.swift
//  SwiftUICandyTodo
//
//  Created by Gabor Sornyei on 2020. 01. 03..
//  Copyright © 2020. Gabor Sornyei. All rights reserved.
//

import SwiftUI

struct NotificationListViewRow: View {
    var notification: CandyNotification
    var body: some View {
        HStack(spacing: 30) {
            InfoView()
            Text(notification.message)
                .font(.custom("Avenir-Book", size: 16))
                .foregroundColor(Color("Dark Blue"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
    }
}

struct NotificationListViewRow_Previews: PreviewProvider {
    static var previews: some View {
        NotificationListViewRow(notification: CandyNotification.examples[0]).previewLayout(.sizeThatFits)
    }
}
