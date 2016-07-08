Pod::Spec.new do |s|
s.name             = 'ICEPhotoBrowse'
s.version          = '1.0.0'
s.summary          = '图片浏览器'
s.description      = <<-DESC
TODO: 图片浏览器功能封装
DESC

s.homepage         = 'https://github.com/My-Pod/ICEPhotoBrowse'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'gumengxiao' => 'rare_ice@163.com' }
s.source           = { :git => 'https://github.com/My-Pod/ICEPhotoBrowse.git', :tag => s.version.to_s }

s.ios.deployment_target = '7.0'
s.source_files = 'Classes/*.{h,m}'
s.dependency 'SDWebImage'
end
