Pod::Spec.new do |s|
  s.name             = 'ScrollViewProxy'
  s.version          = '1.0.3'
  s.summary          = 'Helps with scroll to locations in a ScrollView'
  s.license          = { type: 'MIT' }
  s.homepage         = 'https://github.com/amzd/ScrollViewProxy'
  s.author           = { 'Casper Zandbergen' => 'info@casperzandbergen.nl' }
  s.source           = { :git => 'https://github.com/Amzd/ScrollViewProxy.git', :tag => s.version.to_s }
  s.dependency 'Introspect', '>= 0.1.2'
  s.source_files = 'Sources/**/*.swift'
    
  s.swift_version = '5.1'
  s.ios.deployment_target = '11.0'
  s.tvos.deployment_target = '11.0'
  s.osx.deployment_target = '10.13'
end
