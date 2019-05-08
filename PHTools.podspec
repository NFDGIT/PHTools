
Pod::Spec.new do |s|

  s.name         = "PHTools"
  s.version      = "0.0.1.4"
  s.summary      = " 自定义库 swift 框架"
  s.description  = <<-DESC
            自定义库 swift 版 iOS 开发所需要的常用工具 （包括base类，拓
展工具，常用值)
                   DESC

  s.homepage     = "https://github.com/NFDGIT/PHTools"
  s.license      = "Copyright (c) 2019年 NFDGIT. All rights reserved."
  s.author             = { "NFDGIT" => "942261721@qq.com" }
  s.platform     = :ios, "10.0"
  s.swift_version = '5.0'
  s.source       = { :git => "https://github.com/NFDGIT/PHTools.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "PHTools/**/*.{swift}"
  s.frameworks = "UIKit", "Foundation"

  s.dependency 'SnapKit', '~> 4.2.0'
  s.dependency 'Alamofire', '~> 5.0.0-beta.5'
  s.dependency 'SwiftyJSON', '~> 5.0.0'
  s.dependency 'Kingfisher', '~> 5.0.0' 



end
