#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint video_360.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'video_360'
  s.version          = '0.0.1'
  s.summary          = 'video 360 player'
  s.description      = <<-DESC
video 360 player
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  s.resource_bundles = {
    'video_360' => ['ios/Classes/Swifty360Player/Swifty360Player/Swifty360Player-Info.plist']
  }

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

#   s.dependency 'Swifty360Player', '~> 0.2.7'
#   s.frameworks = 'Swifty360Player'
end