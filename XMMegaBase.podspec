#
# Be sure to run `pod lib lint XMMegaBase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XMMegaBase'
  s.version          = '0.1.2'
  s.summary          = 'A short description of XMMegaBase.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
What's New?
1.AppInfoManager add method appBundleState
2.TTAppLaunchView support launch image, guide and ads.
                       DESC

  s.homepage         = 'http://git.guaniuwu.cn/XMPods/XMMegaBase/wikis/home'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'marco' => 'chyy.meng@gmail.com' }
  s.source           = { :git => 'http://git.guaniuwu.cn/XMPods/XMMegaBase.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://blog.csdn.com/Mamong'

  s.ios.deployment_target = '7.0'

    s.requires_arc = true

    if ENV['IS_SOURCE']
    puts
    '-------------------------------------------------------'
    puts "#{s.name} is source now"
    puts
    '-------------------------------------------------------'
    s.source_files = "#{s.name}/*.{h,m}","#{s.name}/Base/**/*.{h,m}","#{s.name}/Common/**/*.{h,m}","#{s.name}/Categories/*.{h,m}","#{s.name}/Helpers/*.{h,m}","#{s.name}/Macros/*.{h,m}","#{s.name}/Network/*.{h,m}","#{s.name}/SVPullToRefresh/*.{h,m}","#{s.name}/Wechat/*.{h,m}"
    s.public_header_files = "#{s.name}/Products/include/*.h"
    else

    puts
    '-------------------------------------------------------'
    puts "#{s.name} is binary now"
    puts
    '-------------------------------------------------------'
    s.source_files = "#{s.name}/Products/include/*.{h,m}"
    s.public_header_files = "#{s.name}/Products/include/*.h"
    s.ios.vendored_libraries = "#{s.name}/Products/lib/lib#{s.name}.a"
    end

    #s.prefix_header_file = "Example/prefix.pch"
    s.prefix_header_contents = "#import \"#{s.name}Constants.h\""
    s.libraries = 'sqlite3', 'c++', 'z'
    s.resource_bundles = {
     "#{s.name}" => ["#{s.name}/Assets/*.*"]
   }

    s.frameworks = 'UIKit', 'Foundation'
    s.dependency 'AFNetworking', '~> 3.0'
    s.dependency 'SDWebImage', '~> 3.7'
    s.dependency 'MBProgressHUD', '~> 0.9'
    s.dependency 'JSONModel', '~> 1.0.2'
    s.dependency 'BlocksKit', '~> 2.2.5'
    s.dependency 'Reachability', '~> 3.1.1'
    s.dependency 'SwipeView', '~> 1.3.2'
    s.dependency 'Objective-LevelDB', '~> 2.1.4'
    s.dependency 'IQKeyboardManager'
    s.dependency 'WeChat_SDK', '~> 1.7.2.1'
    #s.dependency 'SVPullToRefresh', '~> 0.4.1'
end
