//
//  PDFKit.swift
//
//
//  Created by Adam Wulf on 5/30/24.
//

import PDFKit

/// An extension to the `PDFDocument` class.
public extension PDFDocument {
    /// A computed property that returns the title of the PDF document.
    /// - Returns: The title if it exists, otherwise `nil`.
    var title: String? {
        if let title = documentAttributes?[PDFDocumentAttribute.titleAttribute] as? String {
            return title
        } else {
            return nil
        }
    }

    /// A computed property that returns the author of the PDF document.
    /// - Returns: The author if it exists, otherwise `nil`.
    var author: String? {
        if let author = documentAttributes?[PDFDocumentAttribute.authorAttribute] as? String {
            return author
        } else {
            return nil
        }
    }

    /// A computed property that returns the subject of the PDF document.
    /// - Returns: The subject if it exists, otherwise `nil`.
    var subject: String? {
        if let subject = documentAttributes?[PDFDocumentAttribute.subjectAttribute] as? String {
            return subject
        } else {
            return nil
        }
    }

    /// A computed property that returns the producer of the PDF document.
    /// - Returns: The producer if it exists, otherwise `nil`.
    var producer: String? {
        if let producer = documentAttributes?[PDFDocumentAttribute.producerAttribute] as? String {
            return producer
        } else {
            return nil
        }
    }

    /// A computed property that returns the creator of the PDF document.
    /// - Returns: The creator if it exists, otherwise `nil`.
    var creator: String? {
        if let creator = documentAttributes?[PDFDocumentAttribute.creatorAttribute] as? String {
            return creator
        } else {
            return nil
        }
    }

    /// A computed property that returns the keywords of the PDF document.
    /// - Returns: The keywords if they exist, otherwise `nil`.
    var keywords: [String]? {
        if let keywords = documentAttributes?[PDFDocumentAttribute.keywordsAttribute] as? [String] {
            return keywords
        } else {
            return nil
        }
    }
}
