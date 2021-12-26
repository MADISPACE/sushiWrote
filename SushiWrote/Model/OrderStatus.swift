//
//  OrderStatus.swift
//  SushiWrote
//
//  Created by Влад Мади on 19.12.2021.
//

import Foundation

enum OrderStatus: String, CaseIterable {
    case new = "Новый"
    case preparing = "Готовится"
    case delivering = "Доставка"
    case complete = "Выполнен"
}
