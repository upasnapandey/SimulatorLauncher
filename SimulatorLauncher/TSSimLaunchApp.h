//
//  TSSimLaunchApp.h
//  SimulatorLauncher
//
//  Created by Upasna Pandey on 6/7/16.
//  Copyright © 2016 TradeStation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSSimLaunchApp : NSObject

 - (void)runWithArgc:(int)argc argv:(const char**)argv;
// - (void)startHTTPServer;
@end
