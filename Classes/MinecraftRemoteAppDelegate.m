//
//  MinecraftRemoteAppDelegate.m
//  MinecraftRemote
//
//  Created by Caius Durling on 07/11/2010.
//  Copyright (c) 2010 Swedishcampground Software. All rights reserved.
//

#import "MinecraftRemoteAppDelegate.h"

@implementation MinecraftRemoteAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  // Insert code here to initialize your application
}

- (void)dealloc {

  [window release];
    [super dealloc];
}

@end
