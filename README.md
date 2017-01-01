# SUSPENDED

This module requires "Embedded Binary" be enabled via xcodebuild command, and fixing this JIRA ticket would make it happen:
https://jira.appcelerator.org/browse/TIMOB-23570

# TiSocketIOClient
Socket.io client for Appcelerator Titanium

Finally you can play with Socket.io 1.x together with Appcelerator Titanium!

## Requirements

- Titanium SDK 5.4.0 or later
- Hyperloop module (https://github.com/appcelerator/hyperloop-examples) 1.2 or later
- Ending poverty later
- Curing diseases laster
- Living in peace loving with passion, and lowering the cost of cable.. later

## Install TiSocketIOClient

Copy iphone/ro.toshi.ti.mod.tisocketio-iphone-0.0.1.zip to your project directory and edit tiapp.xml.

```xml
  <modules>
    <module platform="iphone">ro.toshi.ti.mod.tisocketio</module>
  </modules>
```
## Install Hyperloop module

Clone Hyperloop examples project.

```bash
$ git clone https://github.com/appcelerator/hyperloop-examples.git
$ cd hyperloop-examples
```

Copy plugins/hyperloop and modules/{android,iphone}/hyperloop to your project.

```bash
$ cp -r plugins/hyperloop $PROJECT_DIR/plugins/
$ mkdir -p $PROJECT_DIR/modules/{iphone,android}
$ cp -r modules/iphone/hyperloop $PROJECT_DIR/modules/iphone/
$ cp -r modules/android/hyperloop $PROJECT_DIR/modules/android/
```

Edit `tiapp.xml`.
```xml
<property name="run-on-main-thread" type="bool">true</property><!--add-->
  <ios>
    <use-jscore-framework>true</use-jscore-framework><!--add-->
```

```xml
  <plugins>
    <plugin version="1.0">ti.alloy</plugin>
    <plugin>hyperloop</plugin><!--add-->
  </plugins>
```

```xml
  <modules>
    <module>hyperloop</module><!--add-->
    <module platform="iphone">ro.toshi.ti.mod.tisocketio</module>
  </modules>
```

Enable SDK 5.4.0.

```xml
<sdk-version>5.4.0.v20160617074028</sdk-version>
```

## Setup Hyperloop to enable Swift

Add `appc.js` to your project. The file `appc.js` should be placed under your project directory.

```javascript
module.exports = {
  hyperloop: {
    ios: {
			thirdparty: {
				'MyFramework': {
					source: ['src'],
					header: 'src',
					resource: 'src'
				}
			},
      xcodebuild: {
        flags: {
          LD_RUNPATH_SEARCH_PATHS: "$(inherited) /PATH/TO/SocketIOClientSwift.framework/DIR"
        }
      }
    }           
  }
};
```

You can find your `SocketIOClientSwift.framework` under `TiSocketIOClient/iphone/`.

Add `src` directory.

```bash
$ mkdir $PROJECT_DIR/src
```

Add MySwift.swift under the `src` directory for the MAGIC.

```swift
import UIKit

public class MySwiftView : UIImageView {
  convenience init () {
    self.init()
  }
}
```

Voila, now you can build your app.

```bash
$ appc ti build -p ios
```

## Example

```javascript
var socket, io;

// Hyperloop Magic Part: Actually these lines do nothing to your app.
var MySwiftView = require('MyFramework/MySwiftView');
var CGRectMake = require('CoreGraphics').CGRectMake;

// Socket.io
var socket, io;

io = require('ro.toshi.ti.mod.tisocketio');
socket = io.createSocket({
  url: 'http://localhost:9999/'
});

socket.on('connect', function(){
  label.text = "connected";
  socket.emit('message', {message: "hi"});
});

socket.on('serverPush', function(e){
  label.text = e.message;
});

socket.connect();

win.addEventListener('close', function(){
  socket.disconnect();
});
```
