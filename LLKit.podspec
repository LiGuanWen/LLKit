Pod::Spec.new do |s|
s.name         = "LLKit"
s.version      = "1.0.0"
s.summary      = "a collection of HePai utilities and categories"
s.homepage     = "https://github.com/LiGuanWen/LLKit"
s.license      = "MIT"
s.author       = { "LiGuanWen" => "diqidaimu@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => 'https://github.com/LiGuanWen/LLKit.git', :branch => '1.0.0'}
s.requires_arc = true
s.description = %{
   This is a Amazing Project!!!
}

  # s.source_files  = "LLKitClass/**/*.{h,m,mm,a,framework}"


    s.source_files  = 'LLKitClass/**/*.{h,m,mm,a,framework}'
        s.resource = 'LLKitClass/**/*.{xib,png}'

    s.xcconfig = { 
         'USER_HEADER_SEARCH_PATHS' => '$(inherited) $(SRCROOT)/libwebp/src'
     }
    s.framework = 'ImageIO'

    s.dependency 'YYKit'
    s.dependency "FDFullscreenPopGesture"
    s.dependency 'CYLTabBarController'
    s.dependency 'Masonry'
    s.dependency 'MJRefresh'
    s.dependency 'TYPagerController'
    s.dependency 'DZNEmptyDataSet'
    s.dependency 'SDWebImage', '~> 3.7.3'
    s.dependency 'MBProgressHUD', '~> 0.9.1'
    s.dependency 'libwebp'
    s.dependency 'SDWebImage', '~> 4.0.0'
    s.dependency 'SDWebImage/WebP'
    s.dependency 'SDCycleScrollView', '~> 1.66'


# s.default_subspecs = 'LLBaseKit','LLWebP'

#    s.subspec 'LLBaseKit' do |baseKit|
#     baseKit.source_files  = 'LLKitClass/LLBaseKit/**/*.{h,m}'
#     baseKit.resource = 'LLKitClass/LLBaseKit/**/*.{xib,png}'
#     baseKit.dependency 'YYKit'
#     baseKit.dependency "FDFullscreenPopGesture"
#     baseKit.dependency 'CYLTabBarController'
#     baseKit.dependency 'Masonry'
#     baseKit.dependency 'IQKeyboardManager'
#     baseKit.dependency 'MJRefresh'
#     baseKit.dependency 'TYPagerController'
#     baseKit.dependency 'DZNEmptyDataSet'
#     baseKit.dependency 'SDWebImage', '~> 3.7.3'
#     baseKit.dependency 'MBProgressHUD', '~> 0.9.1'
#   end
#  s.subspec 'LLWebP' do |webp|
#     webp.source_files  = 'LLKitClass/LLWebP/**/*.{h,m}'
#     webp.xcconfig = { 
#          'USER_HEADER_SEARCH_PATHS' => '$(inherited) $(SRCROOT)/libwebp/src'
#      }
#     webp.framework = 'ImageIO'
#     webp.dependency 'libwebp'
#     webp.dependency 'SDWebImage','~> 3.7.6'
#     webp.dependency 'SDWebImage/WebP'
#     end

end

