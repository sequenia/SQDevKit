#
# Be sure to run `pod lib lint SQDevKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

    s.platform = :ios
    s.ios.deployment_target = '10.0'
    s.name = "SQDevKit"
    s.summary = "Toolkit for iOS developers by Sequenia"
    s.requires_arc = true

    s.version = "1.0.12"
    s.license  = { :type => "MIT", :file => "LICENSE" }
    s.author   = { 'lab-devoloper' => 'vitaly.banik@sequenia.com' }
    s.homepage = "https://github.com/sequenia/SQDevKit"
    s.source = { :git => 'https://github.com/sequenia/SQDevKit', 
                 :tag => "#{s.version}" }

    s.swift_version = "5.0"

    s.dependency 'SQDifferenceKit', '~> 1.0.1'
    s.dependency 'SwiftyJSON', '~> 5.0.1'

    s.subspec 'SQExtensions' do |extensions|
        extensions.source_files = 'Sources/Extensions/**/*.swift'
        extensions.dependency 'SwiftyJSON', '~> 5.0.1'
    end

    s.subspec 'SQKeyboard' do |keyboard|
        keyboard.source_files = 'Sources/Keyboard/**/*.swift'
    end

    s.subspec 'SQLists' do |lists|
        lists.source_files = 'Sources/Lists/**/*.swift'
        lists.dependency 'SQDifferenceKit', '~> 1.0.1'
    end

    s.subspec 'SQVUPER' do |vuper|
        vuper.source_files = 'Sources/VUPER/**/*.swift'
        vuper.dependency 'SQDevKit/SQExtensions'
    end

    s.subspec 'SQOperations' do |operations|
        operations.source_files = 'Sources/Operations/**/*.swift'
        operations.dependency 'SQDevKit/SQExtensions'
    end

    s.subspec 'SQUIKit' do |uikit|
        uikit.source_files = 'Sources/UIKit/**/*.swift'
        uikit.dependency 'SQDevKit/SQExtensions'
        uikit.dependency 'SQDevKit/SQLists'
        uikit.dependency 'SQDifferenceKit', '~> 1.0.1'
    end

    s.subspec 'SQUIKit' do |uikit|
        uikit.source_files = 'Sources/Defaults/**/*.swift'
        uikit.dependency 'SQDevKit/SQExtensions'
    end
end
