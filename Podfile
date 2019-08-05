source 'https://github.com/CocoaPods/Specs'

project 'Movies/Movies.xcodeproj'
workspace 'Movies.xcworkspace'

platform :ios, '10.3'

use_frameworks!
inhibit_all_warnings!

abstract_target 'default' do
  # Lint
  pod 'SwiftLint'

  target 'Movies' do
    abstract_target 'tests'
    target 'MoviesTests' do
      inherit! :search_paths
    end

    target 'MoviesUITests' do
      inherit! :search_paths
    end
  end
end
