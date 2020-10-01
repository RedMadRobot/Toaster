
Pod::Spec.new do |s|
  s.name             = 'Toaster'
  s.version          = '0.1.1'
  s.summary          = 'Notification view'
  s.homepage         = 'https://git.redmadrobot.com/foundation-ios/toaster.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrey' => 'a.nedov@redmadrobot.com' }
  s.source           = { :git => 'https://git.redmadrobot.com/foundation-ios/toaster.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.swift_version = "5.0"
  s.source_files = 'toaster/Classes/**/*'

end
