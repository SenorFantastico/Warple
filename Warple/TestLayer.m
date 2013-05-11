//
//  TestLayer.m
//  Warple
//
//  Created by Marc Frankel on 2/26/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//

#import "TestLayer.h"



@implementation TestLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	TestLayer *layer = [TestLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)tick:(float)delta {

    
}

-(id)init{
    
    if (self=[super initWithColor:ccc4(255, 255, 255, 255)]) {
        
            }
    return self;
}


@end
