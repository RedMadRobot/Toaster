# Toaster

Нотификации событий.

##  Установка через CocoaPods

```ruby
pod 'Toaster', :git => "https://git.redmadrobot.com/foundation-ios/toaster.git"
```

##  Использование

Импортируйте модуль в вашем проекте

```swift
import Toaster
```

Добавьте протокол  `NotificationPresentable`  и используйте метод `showFeedback()`.

Для расширения шаблонов нотификации, используйте `FeedbackNotification`.

Для изменения настроек(цвета, время и т.д.) нотификации, измените соответствующие атрибуты у  `NotificationAppearance.shared`.
