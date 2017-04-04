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
    baseKit.source_files  = 'LLKit/**/*.{h,m}'
    # ui.exclude_files = 'HEPBaseKit/HPBUIKit/MJRefresh/**/*.{h,m}'

    # ui.subspec 'HPBProgress' do |progress|
    #   progress.source_files = 'HEPBaseKit/HPBUIKit/HPBProgress.{h,m}'
    # end

    # ui.subspec 'HPBInsteresNavTitleView' do |navtitleview|
    #   navtitleview.source_files = 'HEPBaseKit/HPBUIKit/HPBInsteresNavTitleView.{h,m}'
    # end

    # ui.subspec 'NavDotCount' do |navDotCount|
    #   navDotCount.source_files = 'HEPBaseKit/HPBUIKit/NavDotCount.{h,m}'
    # end

    # ui.subspec 'MJRefresh' do |mkrjrefresh|
    #   mkrjrefresh.source_files = 'HEPBaseKit/HPBUIKit/MJRefresh.{h,m}'
    #     mkrjrefresh.resource = 'HEPBaseKit/HPBUIKit/MJRefresh/MJRefresh.bundle'
    # end
    baseKit.resource = 'LLKit/**/*.{xib}'
    baseKit.dependency 'YYKit'
    baseKit.dependency "FDFullscreenPopGesture"
    baseKit.dependency 'CYLTabBarController'
    baseKit.dependency 'Masonry'
    baseKit.dependency 'IQKeyboardManager'
    baseKit.dependency 'MJRefresh'
    baseKit.dependency 'TYPagerController'
    baseKit.dependency 'DZNEmptyDataSet'
    baseKit.dependency 'AFNetworking', '~> 2.6.0'
    baseKit.dependency 'MBProgressHUD', '~> 0.9.1'
    baseKit.dependency 'SDWebImage', '~> 3.7.3'
  end

end

