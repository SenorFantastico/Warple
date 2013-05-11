//
//  WorldSelectLayer.m
//  Warple
//
//  Created by Marc Frankel on 1/29/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//

#import "WorldSelectLayer.h"
#import "MenuLayer.h"
#import "SimpleAudioEngine.h"
#import "WorldOneSelectLayer.h"
#import "WorldTwoSelectLayer.h"
#import "ParticleBackgroundLayer.h"


@implementation WorldSelectLayer
@synthesize swipeRightRecognizer = _swipeRightRecognizer;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	WorldSelectLayer *layer = [WorldSelectLayer node];
    ParticleBackgroundLayer *ParticleLayer = [ParticleBackgroundLayer node];
	[scene addChild:ParticleLayer z:-3];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)LoadWorldOne{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCW transitionWithDuration:.5 scene:[WorldOneSelectLayer scene]]];
}
-(void)LoadWorldTwo{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCW transitionWithDuration:.5 scene:[WorldTwoSelectLayer scene]]];
}

-(NSString *)LoadWorldScores:(int)worldNum{
    NSString *worldName = [NSString stringWithFormat:@"World%iScore",worldNum];
    
    int score = [[NSUserDefaults standardUserDefaults] integerForKey:worldName];
    
    NSString *tempstring = [NSString stringWithFormat:@"%i",score];
    return tempstring;
}
-(void)CheckWorldsWon{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * tempstring = [defaults stringForKey:@"World2"];
    if (tempstring == Nil) {
        [World2 setIsEnabled:NO];
    }
}

-(id)init{
    
    if(self=[super initWithColor:ccc4(255, 255, 255, 0)])
        {
        
            CGSize winSize = [[CCDirector sharedDirector] winSize];
            [[SimpleAudioEngine sharedEngine] preloadEffect:@"button-21.mp3"];
            
            //[[NSUserDefaults standardUserDefaults] setInteger:500 forKey:@"World2Score"];
            //[[NSUserDefaults standardUserDefaults] synchronize];
            
            CCLabelTTF * WorldSelectLabel = [CCLabelTTF labelWithString:@"World Select" fontName:@"Danube" fontSize:32];
            WorldSelectLabel.color =ccc3(255, 255, 255);
            WorldSelectLabel.position = ccp(winSize.width/2, winSize.height-50);
            [self addChild:WorldSelectLabel];
            
            CCMenuItem *World1 = [CCMenuItemImage itemWithNormalImage:@"World_button_1-U.png" selectedImage:@"World_button_1-D.png" target:self selector:@selector(LoadWorldOne)];
            
            World2 = [CCMenuItemImage itemWithNormalImage:@"World_button_2-U.png" selectedImage:@"World_button_2-D.png" disabledImage:@"World_button_2-Dis.png" target:self selector:@selector(LoadWorldTwo)];
            World2.tag = 2;
            
            CCMenu *worldSelect = [CCMenu menuWithItems:World1,World2, nil];
            [worldSelect alignItemsHorizontallyWithPadding:100];
            worldSelect.position = ccp(winSize.width/2,winSize.height/2);
            [self addChild:worldSelect];
            
            CCLabelTTF * label = [CCLabelTTF labelWithString:@"(More Worlds Comming Soon)" fontName:@"Danube" fontSize:14];
            label.color =ccc3(255, 255, 255);
            label.position = ccp(winSize.width/2, winSize.height/2-170);
             [self addChild:label];
            
            //Load World Scores
            CCLabelTTF *World1Score = [CCLabelTTF labelWithString:[self LoadWorldScores:1] fontName:@"Times New Roman" fontSize:10];
            [World1 addChild:World1Score];
            World1Score.color =ccc3(0,0,0);
            World1Score.anchorPoint = ccp(0, 0);
            World1Score.position =ccp(World1.contentSize.width/2-10, -1);
            
            CCLabelTTF *World2Score = [CCLabelTTF labelWithString:[self LoadWorldScores:2] fontName:@"Times New Roman" fontSize:10];
            [World2 addChild:World2Score];
            World2Score.color =ccc3(0,0,0);
            World2Score.anchorPoint = ccp(0, 0);
            World2Score.position =ccp(World2.contentSize.width/2-10, -1);
            
            [self CheckWorldsWon];


            
        }
    return self;
}
-(void)handleRightSwipe:(id)sender{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:.5 scene:[MenuLayer scene]]];
}
-(void)onEnter{
        self.swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipe:)];
        _swipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [[[CCDirector sharedDirector] openGLView] addGestureRecognizer:_swipeRightRecognizer];
    [super onEnter];
    }
- (void)onExit {
        [[[CCDirector sharedDirector] openGLView] removeGestureRecognizer:_swipeRightRecognizer];
    [super onExit];
}

@end
