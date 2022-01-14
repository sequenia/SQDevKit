# SQDevKit

[![GitHub release](https://img.shields.io/github/release/Naereen/StrapDown.js.svg)](https://github.com/sequenia/SQDevKit/releases)
[![GitHub latest commit](https://badgen.net/github/last-commit/Naereen/Strapdown.js)](https://GitHub.com/sequenia/SQDevKit/commit/)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

Набор утилит для упрощения жизни при разработке приложений под iOS

## Установка

### Swift Package Manager
При установке через Swift Package Manager добавьте в ваш `Package.swift` строку:
```
.package(url: "https://github.com/sequenia/SQDevKit.git", .upToNextMajor(from: "2.0.1"))
```

### Cocoapods
При установке через CocoaPods необходимо добавить в начале podfile строки
```
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/sequenia/cocoapods-specs'
```

Затем для установки пода
```
pod 'SQDevKit', :git => 'https://github.com/sequenia/SQDevKit.git'
```

## Модули

### `SQExtensions`
Набор переиспользуемых расширений для различных классов

### `SQKeyboard`
Протокол для обработки показа клавиатуры на экране: подписка на события показа и скрытия клавиатуры, получение высоты клавиатуры и т.д.

### `SQLists` (Deprecated!)
Базовые фабрики ячеек для таблицы и коллекции, основанных на [SQDifferenceKit](https://github.com/sequenia/SQDifferenceKit)

### `SQCompositionLists`
Протоколы и классы для работы с новыми фреймворками от Apple: [UICollectionViewCompositionalLayout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout) для построение layout-а коллекции и [UICollectionViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdiffabledatasource) для контроля изменений в таблице

### `SQVUPER`
Базовые протоколы для VUPER-архитектуры (View - UseCase - Presenter - Entity - Router)

### `SQOperations`
Утилиты для удобной организации операций: обертки асинхронных действий в операцию и финальная операция для очереди

### `SQUIKit`
Полезные UI-компоненты

### `SQDefaults`
Удобная обертка для хранения данных в `UserDefaults`
