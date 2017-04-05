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

s.default_subspecs = 'LLBaseKit'
  s.subspec 'LLBaseKit' do |baseKit|
    baseKit.source_files  = 'LLKit/LLBaseKit/**/*.{h,m}'
    baseKit.resource = 'LLKit/LLBaseKit/**/*.{xib,png}'
    baseKit.dependency 'YYKit'
    baseKit.dependency "FDFullscreenPopGesture"
    baseKit.dependency 'CYLTabBarController'
    baseKit.dependency 'Masonry'
    baseKit.dependency 'IQKeyboardManager'
    baseKit.dependency 'MJRefresh'
    baseKit.dependency 'TYPagerController'
    baseKit.dependency 'DZNEmptyDataSet'
    baseKit.dependency 'AFNetworking', '~> 2.6.0'
    baseKit.dependency 'SDWebImage', '~> 3.7.3'
    baseKit.dependency 'MBProgressHUD', '~> 0.9.1'

  end

end

