platform :ios, '9.0'

target 'Motivetica' do
  use_frameworks!

  # Pods for Motivetica
	pod 'Fabric'
	pod 'Crashlytics'

  target 'MotiveticaTests' do
    inherit! :search_paths
  end

  target 'MotiveticaUITests' do
    inherit! :search_paths
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end
