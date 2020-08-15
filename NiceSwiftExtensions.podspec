Pod::Spec.new do |s|
  s.name = 'NiceSwiftExtensions'
  s.version = '1.0'
  s.license = 'MIT'
  s.summary = '常用的 Swift、Objective-C 和 iOS 扩展'
  s.description = '测试充分, 功能稳定, 注释齐全, 快速上手, 避免重复造轮子, 提高开发效率'
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
