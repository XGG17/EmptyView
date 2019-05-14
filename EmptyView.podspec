
Pod::Spec.new do |s|

  s.name         = "EmptyView"
  s.version      = "1.0.1"
  s.summary      = "空白页封装"
  s.description  = <<-DESC
空白页封装描述
* Markdown 格式
                   DESC
  s.homepage     = "https://github.com/XGG17/EmptyView"
  s.license      = "MIT"
  s.author             = { "xgg" => "2559818083@qq.com" }
  s.source       = { :git => "https://github.com/XGG17/EmptyView.git", :tag => s.version.to_s }
  s.platform     = :ios, "9.0"
  s.source_files  = "DCEmptyView/*.{h,m}"
  s.frameworks = 'UIKit', 'QuartzCore', 'Foundation'
  s.requires_arc = true
  s.dependency "Masonry"
  s.dependency "YLGIFImage"
  s.dependency "lottie-ios"
end
