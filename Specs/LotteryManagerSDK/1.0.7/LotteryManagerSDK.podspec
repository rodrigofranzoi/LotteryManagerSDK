Pod::Spec.new do |spec|

    spec.name         = "LotteryManagerSDK"
    spec.version      = "1.0.7"
    spec.summary      = "Lottery manager sdk in Swift."
  
    spec.description  = "Lottery manager sdk in Swift but this is not description."
    spec.homepage     = "https://github.com/rodrigofranzoi"
  
    spec.license      =  { :type => 'MIT License', :file => 'LICENSE.txt' }
  
    spec.authors      = { "Rodrigo Scroferneker" => "rodrigo.scroferneker@gmail.com" }
    spec.platforms    = { :ios => "12.0" }
    spec.source = { :git => "https://github.com/rodrigofranzoi/LotteryManagerSDK.git", :tag => spec.version }
    spec.swift_version = '4.0'
  
    spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64 i386' }
    spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64 i386' }
    
    spec.source_files = "LotteryManagerSDK/**/*.{swift}"
    spec.dependency 'ReactiveSwift', '~> 6.1'

  end