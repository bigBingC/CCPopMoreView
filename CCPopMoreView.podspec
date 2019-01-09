
Pod::Spec.new do |s|
  s.name         = "CCPopMoreView"
  s.version      = "0.0.1"
  s.summary      = "Pop-up more interface controls."
  s.description  = "Pop-up more interface controls,仿新浪弹出,支持分页展示"
  s.homepage     = "https://github.com/bigBingC/CCPopMoreView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "崔冰" => "https://github.com/bigBingC" }
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/bigBingC/CCPopMoreView.git", :tag => "#{s.version}" }
  s.source_files  = "Class","Class/**/*.{h,m}"
  s.exclude_files = "Class/Exclude"
#  s.dependency "Masonry", "~> 1.1.0"
#  s.dependency "SDWebImage", "~> 4.4.3"
  # s.dependency "JSONKit", "~> 1.4"
  
end
