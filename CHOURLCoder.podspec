#
# Be sure to run `pod lib lint CHOURLCoder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CHOURLCoder'
  s.version          = '0.1.0'
  s.summary          = 'URL Encoding & Decoding'

  s.description      = <<-DESC
            URL Encoding & Decoding
                       DESC

  s.homepage         = 'https://github.com/chojd/CHOURLCoder'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chojd' => 'jingda.cao@gmail.com' }
  s.source           = { :git => 'https://github.com/chojd/CHOURLCoder.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'Sources/*'
  s.public_header_files = 'Sources/*.h'

end
