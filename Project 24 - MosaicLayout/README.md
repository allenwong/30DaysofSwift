1/ Import third-party frameworks, please run command: pod install in current project.

2/ Open the workspace file by Xcode.

Pod command code is below:

platform :ios, '8.0'
use_frameworks!

target 'MosaicLayout' do
pod 'AFNetworking', '~> 2.6'
pod 'ORStackView', '~> 3.0'
pod 'SwiftyJSON', '~> 2.3'
pod "FMMosaicLayout"
end