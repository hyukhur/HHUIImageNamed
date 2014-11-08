Pod::Spec.new do |s|
  s.name         = "HHUIImageNamed"
  s.version      = "0.2.0"
  s.summary      = "UIImage with name by `imageNamed`"

  s.description  = <<-DESC
UIImage with file name by `+[UIImage imageNamed]` and `-[UIImage imageWithContentsOfFile]`
                   DESC

  s.homepage     = "https://github.com/hyukhur/HHUIImageNamed"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Hyuk Hur" => "hyukhur@gmail.com" }
  s.social_media_url   = "http://twitter.com/HyukHur"
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/hyukhur/HHUIImageNamed.git", :tag => s.version.to_s }
  s.source_files  = "Classes/**/*.{h,m}"
  s.public_header_files = "Classes/**/*.h"
  s.requires_arc = true
end
