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

s.default_subspecs = 'HorizontalSelector', 
                     'LLEvaluationStar',
                     'LLExpand',
                     'LLHud',
                     'LLSlidePageScrollView',
                     'LLUtility',
                     'LLWeb',
                     'LLWebp',
                     'LLMJRefreshControl',
                     'NavSegmentView',
                     'LLSwitch'
   #顶部选择 
    s.subspec 'HorizontalSelector' do |hSelector|
        hSelector.source_files =  'LLKitClass/HorizontalSelector/**/*.{h,m,mm}'
        hSelector.resource = 'LLKitClass/HorizontalSelector/**/*.{xib}'
        hSelector.dependency 'YYKit'
    end
   #五星好评
    s.subspec 'LLEvaluationStar' do |evaluationStar|
        evaluationStar.source_files =  'LLKitClass/LLEvaluationStar/**/*.{h,m,mm}'
        evaluationStar.resource = 'LLKitClass/LLEvaluationStar/**/*.{xib,png}'
    end
     #扩展类型
    s.subspec 'LLExpand' do |expand|
        expand.source_files =  'LLKitClass/LLExpand/**/*.{h,m,mm}'
        expand.resource = 'LLKitClass/LLExpand/**/*.{xib}'
    end
    #提示小黑条
    s.subspec 'LLHud' do |hud|
        hud.source_files =  'LLKitClass/LLHud/**/*.{h,m,mm}'
        hud.resource = 'LLKitClass/LLHud/**/*.{xib}'
        hud.dependency 'MBProgressHUD', '~> 0.9.1'
    end
    #顶部滑动等 我的 等页面可用
    s.subspec 'LLSlidePageScrollView' do |slidePageScrollView|
        slidePageScrollView.source_files =  'LLKitClass/LLSlidePageScrollView/**/*.{h,m,mm}'
        slidePageScrollView.resource = 'LLKitClass/LLSlidePageScrollView/**/*.{xib}'
    end
     #常用的方法
    s.subspec 'LLUtility' do |utility|
        utility.source_files =  'LLKitClass/LLUtility/**/*.{h,m,mm}'
        utility.resource = 'LLKitClass/LLUtility/**/*.{xib}'
    end
     #web页面的访问
    s.subspec 'LLWeb' do |web|
        web.source_files =  'LLKitClass/LLWeb/**/*.{h,m,mm}'
        web.resource = 'LLKitClass/LLWeb/**/*.{xib,txt}'
    end
     #显示图片 sdwebimage 扩展
    s.subspec 'LLWebp' do |webp|
        webp.source_files =  'LLKitClass/LLWebp/**/*.{h,m,mm}'
        webp.xcconfig = { 
            'USER_HEADER_SEARCH_PATHS' => '$(inherited) $(SRCROOT)/libwebp/src'
        }
        webp.framework = 'ImageIO'
        webp.dependency 'libwebp'
        webp.dependency 'SDWebImage'
        webp.dependency 'SDWebImage/WebP'
        webp.dependency 'SDWebImage/GIF'
    end
    #刷新
    s.subspec 'LLMJRefreshControl' do |mjRefresh|
        mjRefresh.source_files =  'LLKitClass/LLMJRefreshControl/**/*.{h,m,mm}'
         mjRefresh.dependency 'MJRefresh'
    end
    #顶部选择 
    s.subspec 'NavSegmentView' do |navSegmentView|
        navSegmentView.source_files =  'LLKitClass/NavSegmentView/**/*.{h,m,mm}'
        navSegmentView.resource = 'LLKitClass/NavSegmentView/**/*.{xib}'
    end
    #LLSwitch
    s.subspec 'LLSwitch' do |llSwitch|
        llSwitch.source_files =  'LLKitClass/LLSwitch/**/*.{h,m,mm}'
        llSwitch.resource = 'LLKitClass/LLSwitch/**/*.{xib}'
    end

    # 控制页面返回 顶部状态栏等
    s.dependency "FDFullscreenPopGesture"
    # s.dependency 'CYLTabBarController'
    # s.dependency 'Masonry'
    # s.dependency 'TYPagerController'
    # s.dependency 'DZNEmptyDataSet'
    # s.dependency 'SDCycleScrollView', '~> 1.66'
end

