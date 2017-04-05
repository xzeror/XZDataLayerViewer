Pod::Spec.new do |s|
  s.name         = "XZDataLayerViewer"
  s.version      = "1.1.0"
  s.summary      = "XZDataLayerViewer allows you to see data sent to Google Analytics from your app through Google Tag Manager."
  s.description  = <<-DESC
  XZDataLayerViewer is a library that could help your analytic to see what data sent to Google Analytics from your app, if you are using Google Tag Manager.
                   DESC

  s.homepage     = "https://github.com/xzeror/xzdatalayerviewer"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Andrey Ostanin" => "xzeror@users.noreply.github.com" }
  s.social_media_url   = "http://twitter.com/xzeror"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/xzeror/xzdatalayerviewer.git", :tag => "#{s.version}" }
  s.source_files  = "Library/Sources/**/*.{h,m}"
  s.public_header_files = "Library/Sources/XZDataLayerViewer.h", 
                          "Library/Sources/Viewer/XZCommon.h", 
                          "Library/Sources/Viewer/XZDefaults.h", 
                          "Library/Sources/Viewer/XZDataLayerViewer+Public.h", 
                          "Library/Sources/Store/XZStoreProtocol.h", 
                          "Library/Sources/Store/XZMemoryEventsHistoryStore.h", 
                          "Library/Sources/Logger/XZEventGeneratorProtocol.h", 
                          "Library/Sources/Logger/XZDataLayerObserver.h"
  s.resource  = "LICENSE"
  s.frameworks = "CoreData", "SystemConfiguration"
  s.libraries = "z", "sqlite3"
  s.requires_arc = true
  s.dependency "GoogleTagManager", "~> 3"
end
