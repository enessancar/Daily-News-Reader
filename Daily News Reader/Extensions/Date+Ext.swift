//
//  Date+Ext.swift
//  Daily News Reader
//
//  Created by Enes Sancar on 20.01.2024.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.day().month().year().hour().minute())
    }
}

