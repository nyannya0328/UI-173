//
//  Week.swift
//  UI-173
//
//  Created by にゃんにゃん丸 on 2021/05/03.
//

import SwiftUI

struct Week: Identifiable {
    var id = UUID().uuidString
    var day : String
    var date : String
    var amount : CGFloat
}

