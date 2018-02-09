platform :ios, '9.2'

target 'BioMonitor' do
  use_frameworks!

  pod 'OperaSwift',  '~> 3.0.1'
  pod 'Charts', '~> 3.0.4'
  pod 'Material', '~> 2.12.7'
  pod 'Decodable', '~> 0.6'
  pod 'Whisper', :git => 'https://github.com/hyperoslo/Whisper.git', branch: 'master'
  pod 'Eureka', '~> 4.0'
  pod 'XLSwiftKit', '~> 3.0'
  pod 'SwiftDate', '~> 4.4.2'
  pod 'R.swift', '~> 4.0'
  pod 'Birdsong', '~> 0.6.0'

end

post_install do |installer|
  puts 'Removing static analyzer support'
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['OTHER_CFLAGS'] = "$(inherited) -Qunused-arguments -Xanalyzer -analyzer-disable-all-checks"
          config.build_settings['SWIFT_VERSION'] = '4.0'
      end
  end
end
