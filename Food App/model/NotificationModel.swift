//
//  NotificationModel.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct NotificationModel:Identifiable, Codable {
    var id: Int? = 0
    var refId: Int? = 0
    var isRead: Int? = 0
    var notificationType: Int? = 0
    var title: String? = ""
    var message: String? = ""
    var createdDate: Date? = Date()
}
struct NotificationResModel: Codable {
    var status:String?
    var message:String?
    var payload: [NotificationModel]?
}
