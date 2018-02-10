# HHUIImageNamed

HHUIImageNamed is drop-in style debugging tool to track image's file name when we use `+[UIImage imageNamed]`, `-[UIImage imageWithContentsOfFile]` and so on.

[![Build Status](https://travis-ci.org/hyukhur/HHUIImageNamed.svg?branch=master)](https://travis-ci.org/hyukhur/HHUIImageNamed)
[![codecov](https://codecov.io/gh/hyukhur/HHUIImageNamed/branch/master/graph/badge.svg)](https://github.com/hyukhur/HHUIImageNamed)
[![codebeat badge](https://codebeat.co/badges/2fee3b88-f5d7-4e20-a454-ec5bc9520c09)](https://codebeat.co/projects/github-com-hyukhur-hhuiimagenamed-master)
<!--
[![Platform](https://cocoapod-badges.herokuapp.com/p/HHUIImageNamed/badge.png)](https://github.com/hyukhur/HHUIImageNamed/tree/master/HHUIImageNamed/Classes)
-->
[![Objective-C](https://img.shields.io/badge/Objective-C-green.svg?style=flat-square)](https://developer.apple.com)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/cocoapods/p/HHUIImageNamed.svg?style=flat-square)](https://cocoapods.org/pods/HHUIImageNamed)
[![GitHub license](https://img.shields.io/github/license/hyukhur/HHUIImageNamed.svg?style=flat-square)](https://github.com/hyukhur/HHUIImageNamed/blob/master/LICENSE)
[![Download](https://img.shields.io/cocoapods/dt/HHUIImageNamed.svg?style=flat-square)](http://cocoapods.org/pods/HHUIImageNamed)
[![Twitter](https://img.shields.io/twitter/url/https/github.com/hyukhur/HHUIImageNamed.svg?style=social&style=flat-square)](https://twitter.com/intent/tweet?text=Wow:&url=https%3A%2F%2Fgithub.com%2Fhyukhur%2FHHUIImageNamed)

## Example
To see the example codes, check the unit test codes.
If you couldn't find proper function, let me know. [![GitHub issues](https://img.shields.io/github/issues/hyukhur/HHUIImageNamed.svg?style=flat-square)](https://github.com/hyukhur/HHUIImageNamed/issues)

If you use exploration tools like [FLEX](https://github.com/Flipboard/FLEX), you could find out which file makes the image.

![Sample Image](ImageFileName.png)

## Requirements
* iOS8 or later
  * Actually it's iOS5+. There is no limitation if you can import it.

## Installation

HHUIImageNamed is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
  pod 'HHUIImageNamed'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if target.name.include? "HHUIImageNamed"
        target.build_configurations.each do |config|
          if config.name == 'Debug'
            config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'USE_PRIVATE=1']
          end
        end
      end
    end
  end
```

### Carthage

```ruby
github "hyukhur/HHUIImageNamed"
```
```bash
$ carthage build HHUIImageNamed --configuration Debug
```

## Usage
🚨 It contains "Private API" for Storyboard. Be careful it doesn't contain in your product package.
There is MACRO to control whether it has or not, which is called "USE_PRIVATE". you could find it in `HHUIImageNamed.h`.
Release configuration set it zero by default not to use "Private API".
Even if you won't like to use "Private API", you could track image file names in limitated situations.

Just Drop-in 'HHUIImageNamed' and trace the image name.

## Author

Hyuk Hur

## License

HHUIImageNamed is available under the MIT license. See the LICENSE file for more info.
[![GitHub license](https://img.shields.io/github/license/hyukhur/HHUIImageNamed.svg?style=flat-square)](https://github.com/hyukhur/HHUIImageNamed/blob/master/LICENSE)

