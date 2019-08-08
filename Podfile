source 'https://github.com/CocoaPods/Specs'

install! 'cocoapods',
         :generate_multiple_pod_projects => true,
         :incremental_installation => true

project 'Movies/Movies.xcodeproj'
workspace 'Movies.xcworkspace'

platform :ios, '10.3'

inhibit_all_warnings!

def testing_pods
  pod 'Nimble'
end

abstract_target 'default' do
  supports_swift_versions '>= 5.0'

  # Lint
  pod 'SwiftLint'

  # Sourcery
  pod 'Sourcery'

  target 'Movies' do
    abstract_target 'tests'
    target 'MoviesTests' do
      inherit! :search_paths

      testing_pods
    end

    target 'MoviesUITests' do
      inherit! :search_paths

      testing_pods
    end
  end
end

post_install do |installer|
  fix_deployment_target installer
end

def fix_deployment_target(pod_installer)
  if !pod_installer
    return
  end

  deploymentTargetConfigName = 'IPHONEOS_DEPLOYMENT_TARGET'

  project = pod_installer.pods_project
  deploymentMap = {}

  if !defined? project.build_configurations
    return
  end

  project.build_configurations.each do |config|
    deploymentMap[config.name] = config.build_settings[deploymentTargetConfigName]
  end

  pod_installer.pod_target_subprojects.each do |subproject|
    subproject.build_configurations.each do |config|
      oldTarget = config.build_settings[deploymentTargetConfigName]
      newTarget = deploymentMap[config.name]
      if oldTarget == newTarget
        next
      end

      config.build_settings[deploymentTargetConfigName] = newTarget
    end

    subproject.targets.each do |target|
      target.build_configurations.each do |config|
        oldTarget = config.build_settings[deploymentTargetConfigName]
        newTarget = deploymentMap[config.name]
        if oldTarget == newTarget
          next
        end

        config.build_settings[deploymentTargetConfigName] = newTarget
      end
    end
  end
end
