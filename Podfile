source 'https://cdn.cocoapods.org/' 

install! 'cocoapods',
         :generate_multiple_pod_projects => true,
         :incremental_installation => true

project 'Movies/Movies.xcodeproj'
workspace 'Movies.xcworkspace'

platform :ios, '12'

inhibit_all_warnings!
use_frameworks! :linkage => :static

def testing_pods
  pod 'Nimble', :project_name => 'Testing'
end

supports_swift_versions '>= 5.0'

# UI
pod 'Kingfisher', :project_name => 'UI'

# Lint
pod 'SwiftLint', :project_name => 'Tools'

# Sourcery
pod 'Sourcery', :project_name => 'Tools'

target 'Movies' do
  target 'MoviesTests' do
    inherit! :search_paths

    testing_pods
  end

  target 'MoviesUITests' do
    inherit! :search_paths

    testing_pods
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
