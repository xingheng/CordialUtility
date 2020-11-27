#
# Be sure to run `pod lib lint CordialUtility.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged˙
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CordialUtility'
  s.version          = '1.0.0'
  s.summary          = 'A serials of cordial utilities for UIKit.'
  s.description      = <<-DESC
View, Category, Helper classes, etc.
It also contains some patches for standard libraries.
                       DESC

  s.homepage         = 'https://github.com/xingheng/CordialUtility'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Will Han' => 'xingheng.hax@qq.com' }
  s.source           = { :git => 'https://github.com/xingheng/CordialUtility.git', :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/xingheng'

  s.ios.deployment_target = '8.0'
  s.frameworks = 'UIKit'

  s.default_subspec = 'All'
  s.subspec 'All' do |ss|
    ss.ios.dependency 'CordialUtility/Core'
    ss.ios.dependency 'CordialUtility/String'
    ss.ios.dependency 'CordialUtility/Image'
    ss.ios.dependency 'CordialUtility/Path'
    ss.ios.dependency 'CordialUtility/Date'
    ss.ios.dependency 'CordialUtility/View'
    ss.ios.dependency 'CordialUtility/TableView'
    ss.ios.dependency 'CordialUtility/CollectionView'
    ss.ios.dependency 'CordialUtility/CustomView'
    ss.ios.dependency 'CordialUtility/ViewController'
    ss.ios.dependency 'CordialUtility/Application'
    ss.ios.dependency 'CordialUtility/LayoutConstraint'
  end

  s.subspec 'Core' do |ss|
    ss.source_files = 'CordialUtility/Core/**/*'
    ss.public_header_files = 'CordialUtility/Core/*.h'
  end

  s.subspec 'String' do |ss|
    ss.source_files = 'CordialUtility/String/**/*'
    ss.public_header_files = 'CordialUtility/String/*.h'
  end

  s.subspec 'Image' do |ss|
    ss.source_files = 'CordialUtility/Image/**/*'
    ss.public_header_files = 'CordialUtility/Image/*.h'
  end

  s.subspec 'Path' do |ss|
    ss.source_files = 'CordialUtility/Path/**/*'
    ss.public_header_files = 'CordialUtility/Path/*.h'
  end

  s.subspec 'Date' do |ss|
    ss.source_files = 'CordialUtility/Date/**/*'
    ss.public_header_files = 'CordialUtility/Date/*.h'
  end

  s.subspec 'View' do |ss|
    ss.source_files = 'CordialUtility/View/**/*'
    ss.public_header_files = 'CordialUtility/View/*.h'
  end

  s.subspec 'TableView' do |ss|
    ss.source_files = 'CordialUtility/TableView/**/*'
    ss.public_header_files = 'CordialUtility/TableView/*.h'
  end

  s.subspec 'CollectionView' do |ss|
    ss.source_files = 'CordialUtility/CollectionView/**/*'
    ss.public_header_files = 'CordialUtility/CollectionView/*.h'
  end

  s.subspec 'CustomView' do |ss|
    ss.dependency 'CordialUtility/Core'
    ss.source_files = 'CordialUtility/CustomView/**/*'
    ss.public_header_files = 'CordialUtility/CustomView/*.h'
  end

  s.subspec 'ViewController' do |ss|
    ss.source_files = 'CordialUtility/ViewController/**/*'
    ss.public_header_files = 'CordialUtility/ViewController/*.h'
  end

  s.subspec 'Application' do |ss|
    ss.source_files = 'CordialUtility/Application/**/*'
    ss.public_header_files = 'CordialUtility/Application/*.h'
  end

  s.subspec 'LayoutConstraint' do |ss|
    ss.source_files = 'CordialUtility/LayoutConstraint/**/*'
    ss.public_header_files = 'CordialUtility/LayoutConstraint/*.h'
    ss.dependency 'Masonry'
  end

end
