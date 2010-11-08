//
//  RemoteController.h
//  MinecraftRemote
//
//  Created by Caius Durling on 07/11/2010.
//  Copyright (c) 2010 Swedishcampground Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum
{
  SCGRemoteMovementMode,
  SCGRemoteCameraMode
} SCGRemoteMode;

typedef enum
{
  SCGControlMoveForward,   // w
  SCGControlMoveBackward,  // s
  SCGControlMoveLeft,      // a
  SCGControlMoveRight,     // d
  SCGControlJump,          // <space>
  SCGControlClick,         // <left click>
  SCGControlRightClick,    // <right click>
  SCGControlTiltUp,        // <mouse up>
  SCGControlTiltDown,      // <mouse down>
  SCGControlTiltLeft,      // <mouse left>
  SCGControlTiltRight,     // <mouse right>
  SCGControlModeChange     // change SCGRemoteMode
} SCGControlEventName;

@interface RemoteController : NSObject {
@private
  SCGRemoteMode _state;
}

@property (assign, readonly) SCGRemoteMode state;

- (void) start;
- (void) stop;
- (NSString*) modeString;

@end
