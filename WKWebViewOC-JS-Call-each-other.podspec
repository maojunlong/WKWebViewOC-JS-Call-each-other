Pod::Spec.new do |s|

  s.name         = "WKWebViewOC-JS-Call-each-other"
  s.version      = "1.0.0"
  s.summary      = "A short description of WKWebViewOC-JS-Call-each-other. HAHAHAH pls ignore this s.summary"


  s.description  = "this is description ssss here  s.description"

  s.homepage     = "http://EXAMPLE/Utility"

  s.license      = "MIT(test use)"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "bob.mao" => "961409414@qq.com" }

  s.platform     = :ios

  s.source       = { :git => "https://github.com/maojunlong/WKWebViewOC-JS-Call-each-other.git", :tag => "#{s.version}" }


  s.source_files  = "calculates", "calculates/**/*.{h,m}"

  s.public_header_files = "calculates/**/*.h"

  s.requires_arc = true


end
