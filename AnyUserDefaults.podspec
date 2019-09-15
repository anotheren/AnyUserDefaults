Pod::Spec.new do |s|
    s.name = 'AnyUserDefaults'
    s.version = '1.0.0'
    s.license = 'MIT'
    s.summary = 'AnyUserDefaults is a Morden UserDefaults wapper for Swift'
    s.homepage = 'https://github.com/anotheren/AnyUserDefaults'
    s.authors = { 'anotheren' => 'liudong.edward@gmail.com' }
    s.source = { :git => 'https://github.com/anotheren/AnyUserDefaults.git', :tag => s.version }
  
    s.ios.deployment_target = '10.0'
    s.osx.deployment_target = '10.12'
    s.tvos.deployment_target = '10.0'
    s.watchos.deployment_target = '3.0'
  
    s.swift_versions = ['5.1']
  
    s.source_files = 'Source/AnyUserDefaults/*.swift'
  
    s.frameworks = 'Foundation'
  end