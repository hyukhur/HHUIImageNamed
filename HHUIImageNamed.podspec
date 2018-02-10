Pod::Spec.new do |s|
  s.name         = "HHUIImageNamed"
  s.version      = "1.1.0"
  s.summary      = "Drop-in style Image File Name tracking debug tool"

  s.description  = <<-DESC
HHUIImageNamed is drop-in style debugging tool to track image's file name when we use +[UIImage imageNamed], -[UIImage imageWithContentsOfFile] and so on.
                   DESC

  s.homepage     = "https://github.com/hyukhur/HHUIImageNamed"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Hyuk Hur" => "hyukhur@gmail.com" }
  s.social_media_url   = "http://twitter.com/HyukHur"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/hyukhur/HHUIImageNamed.git", :tag => s.version.to_s }
  s.source_files  = "**/Classes/**/*.{h,m}"
#  s.public_header_files = "**/Classes/**/*.h"
  s.requires_arc = true
  s.prefix_header_contents = "#define USE_PRIVATE 0"
end
