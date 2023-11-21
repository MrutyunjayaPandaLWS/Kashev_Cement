# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'KeshavCement' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for KeshavCement

  pod 'SVPinView', '~> 1.0'
  pod 'lottie-ios'
  pod 'IQKeyboardManagerSwift'
  pod 'SlideMenuControllerSwift'
  pod 'Alamofire', '~> 4.0'
  pod "ImageSlideshow/Alamofire"
  pod 'Toast-Swift', '~> 5.0.1'
  pod "GSMessages"
  pod 'EasyTipView', '~> 2.0.4'
  pod 'DPOTPView'
  pod 'SDWebImage'
  pod 'Kingfisher', '~> 7.6.2'
  pod 'QCropper'
  pod 'LanguageManager-iOS'
  
  pod 'FirebaseAnalytics'
  pod 'Firebase/Core'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'Crashlytics', '~> 3.14.0'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Messaging'
  pod 'Firebase/Analytics'
end
post_install do |installer|
  # ios deployment version
  installer.pods_project.targets.each do |target|
     target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      xcconfig_relative_path = "Pods/Target Support Files/#{target.name}/#{target.name}.#{config.name}.xcconfig"
      file_path = Pathname.new(File.expand_path(xcconfig_relative_path))
      next unless File.file?(file_path)
      configuration = Xcodeproj::Config.new(file_path)
      next if configuration.attributes['LIBRARY_SEARCH_PATHS'].nil?
      configuration.attributes['LIBRARY_SEARCH_PATHS'].sub! 'DT_TOOLCHAIN_DIR', 'TOOLCHAIN_DIR'
      configuration.save_as(file_path)
     end
 end
end
