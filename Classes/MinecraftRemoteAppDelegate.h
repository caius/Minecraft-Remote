//
//  MinecraftRemoteAppDelegate.h
//  MinecraftRemote
//
//  Created by Caius Durling on 07/11/2010.
//  Copyright (c) 2010 Swedishcampground Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RemoteController.h"

@class RemoteController;

@interface MinecraftRemoteAppDelegate : NSObject <NSApplicationDelegate> {
  NSWindow *window;
  RemoteController *_remoteController;
  NSButton *_stateButton;
  NSTextField *_modeLabel;
  NSString *_controlEventString;
}

@property (retain) IBOutlet NSTextField *modeLabel;
@property (retain, readonly) IBOutlet RemoteController *remoteController;
@property (retain) IBOutlet NSWindow *window;
@property (retain) IBOutlet NSButton *stateButton;
@property (copy) NSString *controlEventString;

- (void) pressKey:(NSString*)keyCode;

@end
