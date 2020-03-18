# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

inhibit_all_warnings!

# projectArr = ['TYDrawDemo', 'TYAVPlayerDemo', 'TYToolSet', 'TYOperationDemo', 'TYOpenGLESDemo', 'TYNativeAndWeb', 'TYGameSceneDemo', 'SSVirtualLocation']


# for index in 0..projectArr.length - 1 do 
#   # project in array
#   proj = projectArr[index]

#   target proj do
#     # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
#     #use_frameworks!

#     #workspace
#     workspace 'TYDemos/TYDemos.xcworkspace'
#     # project
#     project 'OtherProjects' + '/' + proj + '/' + proj + '.xcodeproj'

#     pod 'YYText'
#     pod 'YYModel'
#     pod 'WCDB'
#     pod 'Masonry'
#   end

# end

target 'TYWCDBDemo' do
  project 'Demos/TYWCDBDemo/TYWCDBDemo'
  
  pod 'WCDB'
end

target 'TYDrawDemo' do

  proj = 'TYDrawDemo'

  workspace 'Demos/TYDemos.xcworkspace'
  project 'Demos' + '/' + proj + '/' + proj + '.xcodeproj'
  
  pod 'YYModel'
  pod 'WCDB'
  pod 'CocoaLumberjack'
end




# target 'TYDemos' do
#   # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
#   # use_frameworks!

#   # Pods for TYDemos
#   pod 'YYText'
#   pod 'YYModel'
#   pod 'WCDB'
#   pod 'Masonry'

# end

# 解决编译器警告
# The iOS Simulator deployment target is set to x.x, but the range of supported deployment target versions for this platform is 8.0 to 12.0. (in target 'xxx')
# 对第三方库进行了判断若DEPLOYMENT_TARGET<8.0就会切换成8.0
# https://github.com/CocoaPods/CocoaPods/issues/8069
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 8.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
      end
    end
  end
end
