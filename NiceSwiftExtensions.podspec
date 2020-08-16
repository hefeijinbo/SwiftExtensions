Pod::Spec.new do |s|
  s.name = 'NiceSwiftExtensions'
  s.version = '1.1'
  s.license = 'MIT'
  s.summary = '中国最全最好用的 Swift、Objective-C 和 iOS 扩展, 提高您的生产力'
  s.description = 'SwiftExtensions 包含 Swift、Objective-C 和 iOS 丰富的扩展集合, 每个扩展包含详细的中文注释, 让你一键上手, 迅速提高生产力。'
  s.homepage = 'https://github.com/hefeijinbo/SwiftExtensions'
  s.screenshots = 'https://developer.apple.com/assets/elements/icons/swift-playgrounds/swift-playgrounds-96x96_2x.png'
  s.author = { 'jinbo' => 'hefeijinbo@163.com', '微信' => 'hefeijinbo' }
  s.source = { :git => 'https://github.com/hefeijinbo/SwiftExtensions.git', :tag => s.version }
  s.module_name = 'SwiftExtensions'
  s.documentation_url = 'https://juejin.im/post/6861239837890969608/'
  s.ios.deployment_target = '10.0'
  s.swift_version = ['5.0', '5.1', '5.2']
  s.source_files = 'Sources/**/*'
end
