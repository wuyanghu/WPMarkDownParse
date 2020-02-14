#
# Be sure to run `pod lib lint WPMarkDownParse.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WPMarkDownParse'
  s.version          = '0.1.2'
  s.summary          = 'MardDown解析'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
修正缩进偏移量，引用段首才解析，斜体左右为中文时才解析，对齐方式采用左对齐，解决有序嵌套，代码块偏移量
                       DESC

  s.homepage         = 'https://github.com/wuyanghu/WPMarkDownParse'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '823105162@qq.com' => '823105162@qq.com' }
  s.source           = { :git => 'https://github.com/wuyanghu/WPMarkDownParse.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'WPMarkDownParse/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WPMarkDownParse' => ['WPMarkDownParse/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'YYText','1.0.7'
   s.dependency 'WPChained','0.1.2'
   s.dependency 'SDWebImage', '5.0.2'
end
