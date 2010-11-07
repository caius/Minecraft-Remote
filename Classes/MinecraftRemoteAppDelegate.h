//
//  MinecraftRemoteAppDelegate.h
//  MinecraftRemote
//
//  Created by Caius Durling on 07/11/2010.
//  Copyright (c) 2010 Swedishcampground Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MinecraftRemoteAppDelegate : NSObject <NSApplicationDelegate> {
  NSWindow *window;
}

@property (retain) IBOutlet NSWindow *window;

@end
