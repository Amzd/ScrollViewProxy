Pod::Spec.new do |s|
  s.name             = 'ScrollViewProxy'
  s.version          = '1.0.0'
  s.summary          = 'Helps with scroll to locations in a ScrollView'
  s.homepage         = 'https://github.com/amzd/ScrollViewProxy'
  s.author           = { 'Casper Zandbergen' => 'info@casperzandbergen.nl' }
  s.source           = { :git => 'https://github.com/amzd/ScrollViewProxy.git', :tag => s.version.to_s }
  s.dependency 'Introspect'
  s.ios.deployment_target = '11.0'
  s.source_files = 'Sources/**/*.swift'
end
