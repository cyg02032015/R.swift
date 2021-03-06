//
//  values.swift
//  R.swift
//
//  Created by Mathijs Kadijk on 31-01-15.
//  From: https://github.com/mac-cain13/R.swift
//  License: MIT License
//

import Foundation

let ResourceFilename = "R.generated.swift"

let Header = [
  "// This is a generated file, do not edit!",
  "// Generated by R.swift, see https://github.com/mac-cain13/R.swift",
].joinWithSeparator("\n")


let Imports = [
  "import UIKit",
].joinWithSeparator("\n")


let ReuseIdentifier = Struct(
  type: Type(name: "ReuseIdentifier", genericType: Type(name: "T")),
  implements: [Type(name: "CustomStringConvertible")],
  lets: [
    Let(
      name: "identifier",
      type: Type(name: "String")
    )
  ],
  vars: [
    Var(
      isStatic: false,
      name: "description",
      type: Type(name: "String"),
      getter: "return identifier"
    )
  ],
  functions: [],
  structs: [])

let NibResourceProtocol = Protocol(
  type: Type(name: "NibResource"),
  typealiasses: [],
  vars: [
    Var(isStatic: false, name: "name", type: Type._String, getter: "get"),
    Var(isStatic: false, name: "instance", type: Type._UINib, getter: "get")
  ]
)

let ReusableProtocol = Protocol(
  type: Type(name: "Reusable"),
  typealiasses: [
    Typealias(alias: Type(name: "T"), type: nil)
  ],
  vars: [
    Var(isStatic: false, name: "reuseIdentifier", type: ReuseIdentifier.type, getter: "get")
  ]
)

let NibUIViewControllerExtension = Extension(
  type: Type._UIViewController,
  functions: [
    Initializer(
      type: .Convenience,
      parameters: [
        Function.Parameter(name: "nib", type: Type(name: "NibResource"))
      ],
      body: "self.init(nibName: nib.name, bundle: nil)"
    ) as Func
  ]
)

let ReuseIdentifierUITableViewExtension = Extension(
  type: Type._UITableView,
  functions: [
    Function(
      isStatic: false,
      name: "dequeueReusableCellWithIdentifier",
      generics: "T : \(Type._UITableViewCell)",
      parameters: [
        Function.Parameter(name: "identifier", type: ReuseIdentifier.type),
        Function.Parameter(name: "forIndexPath", localName: "indexPath", type: Type._NSIndexPath.asOptional())
      ],
      returnType: Type(name: "T", genericType: nil, optional: true),
      body: "if let indexPath = indexPath {\n  return dequeueReusableCellWithIdentifier(identifier.identifier, forIndexPath: indexPath) as? T\n}\nreturn dequeueReusableCellWithIdentifier(identifier.identifier) as? T"
    ),

    Function(
      isStatic: false,
      name: "dequeueReusableCellWithIdentifier",
      generics: "T : \(Type._UITableViewCell)",
      parameters: [
        Function.Parameter(name: "identifier", type: ReuseIdentifier.type),
      ],
      returnType: Type(name: "T", genericType: nil, optional: true),
      body: "return dequeueReusableCellWithIdentifier(identifier.identifier) as? T"
    ),

    Function(
      isStatic: false,
      name: "dequeueReusableHeaderFooterViewWithIdentifier",
      generics: "T : \(Type._UITableViewHeaderFooterView)",
      parameters: [
        Function.Parameter(name: "identifier", type: ReuseIdentifier.type),
      ],
      returnType: Type(name: "T", genericType: nil, optional: true),
      body: "return dequeueReusableHeaderFooterViewWithIdentifier(identifier.identifier) as? T"
    ),

    Function(
      isStatic: false,
      name: "registerNib",
      generics: "T: \(NibResourceProtocol.type) where T: \(ReusableProtocol.type), T.T: UITableViewCell",
      parameters: [
        Function.Parameter(name: "nibResource", type: Type(name: "T"))
      ],
      returnType: Type._Void,
      body: "registerNib(nibResource.instance, forCellReuseIdentifier: nibResource.reuseIdentifier.identifier)"
    ),

    Function(
      isStatic: false,
      name: "registerNibs",
      generics: "T: \(NibResourceProtocol.type) where T: \(ReusableProtocol.type), T.T: UITableViewCell",
      parameters: [
        Function.Parameter(name: "nibResources", type: Type(name: "[T]"))
      ],
      returnType: Type._Void,
      body: "nibResources.forEach(registerNib)"
    ),

    Function(
      isStatic: false,
      name: "registerNibForHeaderFooterView",
      generics: "T: \(NibResourceProtocol.type) where T: \(ReusableProtocol.type), T.T: UIView",
      parameters: [
        Function.Parameter(name: "nibResource", type: Type(name: "T"))
      ],
      returnType: Type._Void,
      body: "registerNib(nibResource.instance, forHeaderFooterViewReuseIdentifier: nibResource.reuseIdentifier.identifier)"
    )
  ]
)

let ReuseIdentifierUICollectionViewExtension = Extension(
  type: Type._UICollectionView,
  functions: [
    Function(
      isStatic: false,
      name: "dequeueReusableCellWithReuseIdentifier",
      generics: "T: \(Type._UICollectionViewCell)",
      parameters: [
        Function.Parameter(name: "identifier", type: ReuseIdentifier.type),
        Function.Parameter(name: "forIndexPath", localName: "indexPath", type: Type._NSIndexPath)
      ],
      returnType: Type(name: "T", genericType: nil, optional: true),
      body: "return dequeueReusableCellWithReuseIdentifier(identifier.identifier, forIndexPath: indexPath) as? T"
    ),

    Function(
      isStatic: false,
      name: "dequeueReusableSupplementaryViewOfKind",
      generics: "T: \(Type._UICollectionReusableView)",
      parameters: [
        Function.Parameter(name: "elementKind", type: Type._String),
        Function.Parameter(name: "withReuseIdentifier", localName: "identifier", type: ReuseIdentifier.type),
        Function.Parameter(name: "forIndexPath", localName: "indexPath", type: Type._NSIndexPath)
      ],
      returnType: Type(name: "T", genericType: nil, optional: true),
      body: "return dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: identifier.identifier, forIndexPath: indexPath) as? T"
    ),

    Function(
      isStatic: false,
      name: "registerNib",
      generics: "T: \(NibResourceProtocol.type) where T: \(ReusableProtocol.type), T.T: UICollectionViewCell",
      parameters: [
        Function.Parameter(name: "nibResource", type: Type(name: "T"))
      ],
      returnType: Type._Void,
      body: "registerNib(nibResource.instance, forCellWithReuseIdentifier: nibResource.reuseIdentifier.identifier)"
    ),

    Function(
      isStatic: false,
      name: "registerNibs",
      generics: "T: \(NibResourceProtocol.type) where T: \(ReusableProtocol.type), T.T: UICollectionViewCell",
      parameters: [
        Function.Parameter(name: "nibResources", type: Type(name: "[T]"))
      ],
      returnType: Type._Void,
      body: "nibResources.forEach(registerNib)"
    ),

    Function(
      isStatic: false,
      name: "registerNib",
      generics: "T: \(NibResourceProtocol.type) where T: \(ReusableProtocol.type), T.T: UICollectionReusableView",
      parameters: [
        Function.Parameter(name: "nibResource", type: Type(name: "T")),
        Function.Parameter(name: "forSupplementaryViewOfKind", localName: "kind", type: Type._String)
      ],
      returnType: Type._Void,
      body: "registerNib(nibResource.instance, forSupplementaryViewOfKind: kind, withReuseIdentifier: nibResource.reuseIdentifier.identifier)"
    ),

    Function(
      isStatic: false,
      name: "registerNibs",
      generics: "T: \(NibResourceProtocol.type) where T: \(ReusableProtocol.type), T.T: UICollectionReusableView",
      parameters: [
        Function.Parameter(name: "nibResources", type: Type(name: "[T]")),
        Function.Parameter(name: "forSupplementaryViewOfKind", localName: "kind", type: Type._String)
      ],
      returnType: Type._Void,
      body: "nibResources.forEach { self.registerNib($0, forSupplementaryViewOfKind: kind) }"
    ),
  ]
)

let IndentationString = "  "

let Ordinals = [
  (number: 1, word: "first"),
  (number: 2, word: "second"),
  (number: 3, word: "third"),
  (number: 4, word: "fourth"),
  (number: 5, word: "fifth"),
  (number: 6, word: "sixth"),
  (number: 7, word: "seventh"),
  (number: 8, word: "eighth"),
  (number: 9, word: "ninth"),
  (number: 10, word: "tenth"),
  (number: 11, word: "eleventh"),
  (number: 12, word: "twelfth"),
  (number: 13, word: "thirteenth"),
  (number: 14, word: "fourteenth"),
  (number: 15, word: "fifteenth"),
  (number: 16, word: "sixteenth"),
  (number: 17, word: "seventeenth"),
  (number: 18, word: "eighteenth"),
  (number: 19, word: "nineteenth"),
  (number: 20, word: "twentieth"),
]

// Roughly based on http://www.unicode.org/Public/emoji/1.0//emoji-data.txt
let emojiRanges = [
  0x2600...0x27BF,
  0x1F300...0x1F6FF,
  0x1F900...0x1F9FF,
  0x1F1E6...0x1F1FF,
]

let BlacklistedCharacters = { () -> NSCharacterSet in
  let blacklist = NSMutableCharacterSet(charactersInString: "")
  blacklist.formUnionWithCharacterSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
  blacklist.formUnionWithCharacterSet(NSCharacterSet.punctuationCharacterSet())
  blacklist.formUnionWithCharacterSet(NSCharacterSet.symbolCharacterSet())
  blacklist.formUnionWithCharacterSet(NSCharacterSet.illegalCharacterSet())
  blacklist.formUnionWithCharacterSet(NSCharacterSet.controlCharacterSet())
  blacklist.removeCharactersInString("_")

  emojiRanges.forEach {
    let range = NSRange(location: $0.startIndex, length: $0.endIndex - $0.startIndex)
    blacklist.removeCharactersInRange(range)
  }

  return blacklist
}()

// Extensions
let AssetFolderExtensions: Set<String> = ["xcassets"]
let AssetExtensions: Set<String> = ["launchimage", "imageset"] // Note: "appiconset" is not loadable by default, so it's not included here
let ImageExtensions: Set<String> = ["tiff", "tif", "jpg", "jpeg", "gif", "png", "bmp", "bmpf", "ico", "cur", "xbm"] // See "Supported Image Formats" on https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIImage_Class/
let FontExtensions: Set<String> = ["otf", "ttf"]
let StoryboardExtensions: Set<String> = ["storyboard"]
let NibExtensions: Set<String> = ["xib"]

let CompiledResourcesExtensions: Set<String> = AssetFolderExtensions.union(StoryboardExtensions).union(NibExtensions)

let ElementNameToTypeMapping = [
  "viewController": Type._UIViewController,
  "tableViewCell": Type(name: "UITableViewCell"),
  "tabBarController": Type(name: "UITabBarController"),
  "glkViewController": Type(name: "GLKViewController"),
  "pageViewController": Type(name: "UIPageViewController"),
  "tableViewController": Type(name: "UITableViewController"),
  "splitViewController": Type(name: "UISplitViewController"),
  "navigationController": Type(name: "UINavigationController"),
  "avPlayerViewController": Type(name: "AVPlayerViewController"),
  "collectionViewController": Type(name: "UICollectionViewController"),
]

let SwiftKeywords = ["class", "deinit", "enum", "extension", "func", "import", "init", "internal", "let", "operator", "private", "protocol", "public", "static", "struct", "subscript", "typealias", "var", "break", "case", "continue", "default", "do", "else", "fallthrough", "for", "if", "in", "return", "switch", "where", "while", "as", "dynamicType", "false", "is", "nil", "self", "Self", "super", "true", "__COLUMN__", "__FILE__", "__FUNCTION__", "__LINE__"]
