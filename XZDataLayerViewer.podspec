#
#  Be sure to run `pod spec lint XZDataLayerViewer.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "XZDataLayerViewer"
  s.version      = "1.0.0"
  s.summary      = "XZDataLayerViewer allows you to see data sent to Google Analytics from your app through Google Tag Manager."
  s.description  = <<-DESC
  XZDataLayerViewer is a library that could help your analytic to see what data sent to Google Analytics from your app, if you are using Google Tag Manager.
                   DESC

  s.homepage     = "http://bitbucket.org/xzeror/xzdatalayerviewer"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Andrey Ostanin" => "x0r.developer@gmail.com" }
  s.social_media_url   = "http://twitter.com/xzeror"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "http://bitbucket.org/xzeror/xzdatalayerviewer.git", :tag => "#{s.version}" }
  s.source_files  = "Library/Sources/**/*.{h,m}"
  s.public_header_files = "Library/Sources/XZDataLayerViewer.h", 
                          "Library/Sources/Viewer/XZCommon.h", 
                          "Library/Sources/Viewer/XZDefaults.h", 
                          "Library/Sources/Viewer/XZDataLayerViewer+Public.h", 
                          "Library/Sources/Viewer/XZStoreProtocol.h", 
                          "Library/Sources/Viewer/XZEventGeneratorProtocol.h", 
                          "Library/Sources/Viewer/XZMemoryEventsHistoryStore.h", 
                          "Library/Sources/Viewer/XZDataLayerObserver.h"
  s.resource  = "LICENSE"
  s.frameworks = "CoreData", "SystemConfiguration"
  s.libraries = "z", "sqlite3"
  s.requires_arc = true
  s.dependency "GoogleTagManager", "~> 3"
end
