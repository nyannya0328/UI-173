//
//  CustomShape.swift
//  UI-173
//
//  Created by にゃんにゃん丸 on 2021/05/03.
//

import SwiftUI

struct CustomShape: Shape {
    
    var corner : UIRectCorner
    var radi : CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radi, height: radi))
        return Path(path.cgPath)
    }
}


