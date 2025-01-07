platform :ios, '12.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/yintao910816/TGSubmodoules.git'

install! 'cocoapods',
         :warn_for_unused_master_specs_repo => false,  # 禁用未使用主库的警告
         :generate_multiple_pod_projects => true      # 为每个 Pod 生成单独的项目

workspace 'TextSprite.xcworkspace'

target 'TextSprite' do
  #  pod 'Alamofire',               '5.8.0'
  #  pod 'Moya',                    '15.0.0'
  
  #  pod 'HandyJSON',               '5.0.2'
  #  pod 'SQLite.swift',            '0.15.3'
#  pod 'TGSubmodoules/Display',              '1.1.0'
  pod 'TGSubmodoules',              '1.1.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
end
