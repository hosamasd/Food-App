//
//  NotificationModel.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct NotificationModel:Identifiable, Codable {
    var id: Int? = 0
    var ref_id: Int? = 0
    var is_read: Int? = 0
    var notification_type: Int? = 0
    var title: String? = ""
    var message: String? = ""
    var created_date: Date? = Date()
}
struct NotificationResModel: Codable {
    var status:String?
    var message:String?
    var payload: [NotificationModel]?
}
