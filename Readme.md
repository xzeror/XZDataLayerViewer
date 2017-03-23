# XZDataLayerViewer

Debugging mobile application analytics could be hard. XZDataLayerViewer is a library that could help your analytic to see what data sent to Google Analytics from your app, if you are using Google Tag Manager.

# Installation

## Using CocoaPods

In your Podfile add this line:

`pod 'XZDataLayerViewer'`

## Old School

Just add the files in `Sources` and import `XZDataLayerViewer.h` in your AppDelegate.

# Usage

```
// AppDelegate.m

#import "XZDataLayerViewer.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [XZDataLayerViewer configureWithTagManger:[TAGManager instance] store:XZDefaultStore eventGenerator:XZDefaultObserver maxHistoryItems:100];
    // ...
    UIViewController *dataLayerViewerInterface = [[XZDataLayerViewer sharedInstance] viewerInterface];
	[yourViewController presentViewController:dataLayerViewerInterface animated:YES completion:nil];
}

```

# Extending

## Data storage

By default library uses in memory storage. You may implement your own store conforming to XZStoreProtocol and write data to file or server.

## When data stored

By default library observers every push to Google Tag Manager data layer and saves data layer state in storage. If you want to do this in other moments you should implement your own observer that conforms to XZEventGeneratorProtocol

# License

(The MIT License)

Copyright © 2017 Andrey Ostanin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of
the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


