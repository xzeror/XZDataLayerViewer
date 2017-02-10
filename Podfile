source 'https://github.com/CocoaPods/Specs.git'
#platform :ios, '10.0'
# base things
pod 'XZAsserts', :git => 'https://github.com/xzeror/XZAsserts.git'
#pod 'CocoaLumberjack', '~> 2.0.0'
pod 'BlocksKit'
pod 'Overline-BlocksKit', :inhibit_warnings => true
pod 'PromiseKit'
#pod 'MGEvents'
#pod 'FXNotifications'
#pod 'AutoCoding'
pod 'StandardPaths', :inhibit_warnings => true
pod 'JSONKit', :git => 'https://github.com/xzeror/JSONKit.git', :branch => 'develop', :inhibit_warnings => true
pod 'uiview-frame-helpers', :git => 'https://github.com/xzeror/uiview-frame-helpers.git', :branch => 'my_changes'
pod 'libextobjc'
pod 'Realm'
pod 'Firebase'
pod 'Firebase/Messaging'
pod 'Firebase/AppIndexing'

# AutoLayout related stuff
pod 'PureLayout'		# simplifies autolayout creation

# other stuff
pod 'iRate', :inhibit_warnings => true
pod 'ZXingObjC'
pod 'Lockbox'
pod 'MKNetworkKit', :git => 'https://github.com/xzeror/MKNetworkKit.git', :branch => 'master', :inhibit_warnings => true
pod 'DAKeyboardControl', :git => 'https://github.com/aelam/DAKeyboardControl.git'
pod 'QuickDialog', :git => 'https://github.com/escoz/QuickDialog.git', :commit => 'dc071329c982085f9fe7572bf753e59b9741f348', :inhibit_warnings => true
pod 'UIResponder+KeyboardCache'
pod 'RESideMenu', :git => 'https://github.com/acherushnikov/RESideMenu.git', :branch => 'develop'
pod 'MGBoxKit'
pod 'SWRevealTableViewCell'
pod 'AHKNavigationController'
pod 'JVFloatLabeledTextField', :git => 'https://github.com/acherushnikov/JVFloatLabeledTextField.git', :branch => 'develop'
pod '1PasswordExtension'
pod 'REComposeViewController', :git => 'https://github.com/acherushnikov/REComposeViewController.git', :branch => 'develop'
pod 'VK-ios-sdk'
pod 'JLRoutes'
pod 'LMDropdownView'
pod 'PayPal-iOS-SDK/Core'
pod 'FLAnimatedImage', '~> 1.0'
pod 'ZLSwipeableView'


target :development do
	link_with 'OzonOnlineStoreDev'
	pod 'iOS-Hierarchy-Viewer', :inhibit_warnings => true
#    pod 'Calabash', '~>0.9.168'
	pod 'dyci', :git => 'https://github.com/DyCI/dyci-main.git'
	pod 'OHHTTPStubs'
end

#target :beta_testing do
#	link_with 'OzonOnlineStoreBeta'
#end

target :test, :exclusive => true do
	link_with 'OzonOnlineStoreDevTests','OzonOnlineStoreTests'
	pod 'OCMock'
	pod 'Expecta'
end

post_install do |installer_representation|
	installer_representation.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			if config.name != 'Debug'
                config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = '$(inherited) __FILE__=\"\"'
                config.build_settings['OTHER_CFLAGS']                 = '$(inherited) -Wno-builtin-macro-redefined'
			end
		end
	end
end
