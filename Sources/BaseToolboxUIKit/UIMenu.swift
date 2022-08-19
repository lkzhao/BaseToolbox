//
//  File.swift
//  
//
//  Created by Luke Zhao on 8/19/22.
//

import UIKit

@resultBuilder
public enum MenuElementsBuilder {
    public static func buildExpression(_ expression: UIMenuElement) -> [UIMenuElement] {
        [expression]
    }
    public static func buildExpression(_ expression: [UIMenuElement]) -> [UIMenuElement] {
        expression
    }
    public static func buildBlock(_ segments: [UIMenuElement]...) -> [UIMenuElement] {
        segments.flatMap { $0 }
    }
    public static func buildIf(_ segments: [UIMenuElement]?...) -> [UIMenuElement] {
        segments.flatMap { $0 ?? [] }
    }
    public static func buildEither(first: [UIMenuElement]) -> [UIMenuElement] {
        first
    }
    public static func buildEither(second: [UIMenuElement]) -> [UIMenuElement] {
        second
    }
    public static func buildArray(_ components: [[UIMenuElement]]) -> [UIMenuElement] {
        components.flatMap { $0 }
    }
    public static func buildLimitedAvailability(_ component: [UIMenuElement]) -> [UIMenuElement] {
        component
    }
}

public extension UIMenu {
    convenience init(
        title: String = "",
        image: UIImage? = nil,
        identifier: UIMenu.Identifier? = nil,
        options: UIMenu.Options = [],
        @MenuElementsBuilder builder: () -> [UIMenuElement]
    ) {
        self.init(
            title: title,
            image: image,
            identifier: identifier,
            options: options,
            children: builder()
        )
    }
}
