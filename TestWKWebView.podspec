Pod::Spec.new do |s|
  s.name         = 'WKWebViewOC-JS-Call-each-other'
  s.summary      = 'test the web view and object-c invoked.'
  s.version      = '1.0.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'user' => 'bob.mao' }
  s.social_media_url = 'https://www.baidu.com'
  s.homepage     = 'https://github.com/maojunlong'
  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'git@github.com:maojunlong/WKWebViewOC-JS-Call-each-other.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'WKWebViewOC-JS-Call-each-other/calculates/*.{h,m}'
  s.public_header_files = 'WKWebViewOC-JS-Call-each-other/calculates/*.{h}'
  
  s.frameworks = 'UIKit', 'CoreFoundation'

end
