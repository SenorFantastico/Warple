//
//  IntroLayer.m
//  Warple
//
//  Created by Marc Frankel on 1/6/13.
//  Copyright Señor Fantástico Games 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "MenuLayer.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(void)LoadMainMenu{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:3.0 scene:[MenuLayer scene] ]];
}

// 
-(id) init
{
	if( (self=[super init])) {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		CCSprite *background;
		
		background = [CCSprite spriteWithFile:@"logo2.png"];
		background.position = ccp(size.width/2, size.height/2);

		// add the label as a child to this Layer
		[self addChild: background];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults objectForKey:@"firstRun"])
            [defaults setObject:[NSDate date] forKey:@"firstRun"];
        [defaults setObject:@"True" forKey:@"HasWon_1.1"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self scheduleOnce:@selector(LoadMainMenu) delay:4];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
	
}
@end
