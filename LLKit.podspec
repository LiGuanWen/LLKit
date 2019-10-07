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

s.default_subspecs = 'LLUIKit',
                     'HorizontalSelector',
                     'LLEvaluationStar',
                     'LLExpand',
                     'LLHud',
                     'LLSlidePageScrollView',
                     'LLUtility',
                     'LLMJRefreshControl',
                     'LLNavSegmentView',
                     'LLSwitch'

   # UIKit
    s.subspec 'LLUIKit' do |uikit|
         uikit.subspec 'Views' do |views|
            views.source_files = 'LLKitClass/LLUIKit/Views/**/*.{h,m}'
            views.resource = 'LLKitClass/LLUIKit/Views/**/*.{xib}'

        end
          uikit.subspec 'CollectionViewCells' do |collectionViewCells|
            collectionViewCells.source_files = 'LLKitClass/LLUIKit/CollectionViewCells/**/*.{h,m}'
            collectionViewCells.resource = 'LLKitClass/LLUIKit/CollectionViewCells/**/*.{xib}'

        end
          uikit.subspec 'Controllers' do |controllers|
            controllers.source_files = 'LLKitClass/LLUIKit/Controllers/**/*.{h,m}'
            controllers.resource = 'LLKitClass/LLUIKit/Controllers/**/*.{xib}'

        end
          uikit.subspec 'TableViewCells' do |tableViewCells|
            tableViewCells.source_files = 'LLKitClass/LLUIKit/TableViewCells/**/*.{h,m}'
            tableViewCells.resource = 'LLKitClass/LLUIKit/TableViewCells/**/*.{xib}'

        end
        uikit.dependency 'DZNEmptyDataSet'

    end
 
   #顶部选择
    s.subspec 'HorizontalSelector' do |hSelector|
        hSelector.source_files =  'LLKitClass/HorizontalSelector/**/*.{h,m,mm}'
        hSelector.resource = 'LLKitClass/HorizontalSelector/**/*.{xib}'
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
  
    #刷新
    s.subspec 'LLMJRefreshControl' do |mjRefresh|
        mjRefresh.source_files =  'LLKitClass/LLMJRefreshControl/**/*.{h,m,mm}'
        mjRefresh.dependency 'MJRefresh'
    end
    #顶部选择 
    s.subspec 'LLNavSegmentView' do |navSegmentView|
        navSegmentView.source_files =  'LLKitClass/LLNavSegmentView/**/*.{h,m,mm}'
        navSegmentView.resource = 'LLKitClass/LLNavSegmentView/**/*.{xib}'
    end
    #LLSwitch
    s.subspec 'LLSwitch' do |llSwitch|
        llSwitch.source_files =  'LLKitClass/LLSwitch/**/*.{h,m,mm}'
        llSwitch.resource = 'LLKitClass/LLSwitch/**/*.{xib}'
    end

   
    s.dependency "FDFullscreenPopGesture"     # 控制页面返回 顶部状态栏等
    s.dependency "TPKeyboardAvoiding"         # 键盘输入 自动对应到哪一行（scrollview tableview collectionview）
    s.dependency 'YYKit'                      # 常用便捷方法kit


    # s.dependency 'CYLTabBarController'   #tabbar
    # s.dependency 'Masonry'      #手写约束
    # s.dependency 'TYPagerController'  #多页列表
    # s.dependency 'DZNEmptyDataSet'   #空白页
    # s.dependency 'SDCycleScrollView', '~> 1.66'  #滚动广告brand
  
    # s.dependency 'HHTransition'   #转场动画


# pod 'HJTabViewController', '~> 1.0'   #防网易页面 

#https://codeload.github.com/panghaijiao/HJTabViewController/zip/master

end

