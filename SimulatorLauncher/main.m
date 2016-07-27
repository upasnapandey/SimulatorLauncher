//
//  main.m
//  SimulatorLauncher
//
//  Created by Upasna Pandey on 6/6/16.
//  Copyright © 2016 TradeStation. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TSSimLaunchApp.h"

int main(int argc, const char * argv[]) {
    TSSimLaunchApp *app = [[TSSimLaunchApp alloc] init];
    
    [app runWithArgc:argc argv:argv];
}



