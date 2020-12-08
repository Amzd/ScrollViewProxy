Pod::Spec.new do |s|
  s.name             = 'ScrollViewProxy'
  s.version          = '1.0.0'
  s.summary          = 'Helps with scroll to locations in a ScrollView'
  s.license          = { type: 'MIT' }
  s.homepage         = 'https://github.com/amzd/ScrollViewProxy'
  s.author           = { 'Casper Zandbergen' => 'info@casperzandbergen.nl' }
  s.source           = { :git => 'https://github.com/amzd/ScrollViewProxy.git', :tag => s.version.to_s }
  s.dependency 'AmzdIntrospect', '>= 0.1.1'
  s.source_files = 'Sources/**/*.swift'
    
  s.swift_version = '5.1'
  s.ios.deployment_target = '11.0'
  s.tvos.deployment_target = '11.0'
  s.osx.deployment_target = '10.13'
end
