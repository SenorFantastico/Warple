//
//  GameOverLayer.m
//  Warple
//
//  Created by Marc Frankel on 3/6/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//

#import "GameOverLayer.h"
#import "Game.h"
#import "WorldOneSelectLayer.h"
#import "MenuLayer.h"
#import "WorldSelectLayer.h"
#import "SimpleAudioEngine.h"
#import "WorldTwoSelectLayer.h"


@implementation GameOverLayer


+(CCScene *) sceneWithLevelData:(int)mapName mapWorldNum:(int)mapWorldnum
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOverLayer *layer = [[GameOverLayer node]initWithLevelData:mapName mapWorldNum:mapWorldnum];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id)initWithLevelData:(int)maplevelNum mapWorldNum:(int)mapWorldNum{
    
    if (self=[super initWithColor:ccc4(255, 255, 255, 0)]) {
        PlayersLevel =maplevelNum;
        PlayerWorld = mapWorldNum;
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"button-21.mp3"];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF *Header = [CCLabelTTF labelWithString:@"Game Over" fontName:@"Danube" fontSize:40];
        [self addChild:Header];
        Header.position = ccp(winSize.width/2,winSize.height+winSize.height*.3);
        
        id move = [CCMoveTo actionWithDuration:1 position:ccp(winSize.width/2, winSize.height-winSize.height*.15)];
        id action = [CCEaseBounce actionWithAction:move];
        [Header runAction:action];
        
        CCMenuItemImage * RestartMenuItem = [CCMenuItemImage itemWithNormalImage:@"GO_button_back-U.png" selectedImage:@"GO_button_back-D.png" target:self selector:@selector(RestartGame:)];
        
        CCMenuItemImage * LevelSelectMenuItem = [CCMenuItemImage itemWithNormalImage:@"GO_button_LevelSelect-U.png" selectedImage:@"GO_button_LevelSelect-D.png" target:self selector:@selector(LoadLevelSelect:)];
        
        CCMenuItemImage * WorldSelectMenuItem = [CCMenuItemImage itemWithNormalImage:@"GO_button_WorldSelect-U.png" selectedImage:@"GO_button_WorldSelect-D.png" target:self selector:@selector(LoadWorldSelect:)];
        
        CCMenuItemImage * MainMenuMenuItem = [CCMenuItemImage itemWithNormalImage:@"GO_button_MainMenu-U.png" selectedImage:@"GO_button_MainMenu-D.png" target:self selector:@selector(LoadMainMenu:)];
        
        CCMenu *GOMenu = [CCMenu menuWithItems:RestartMenuItem,LevelSelectMenuItem,WorldSelectMenuItem, MainMenuMenuItem,nil];
        
        GOMenu.position = ccp(winSize.width/2,winSize.height*.4);
        [GOMenu alignItemsVerticallyWithPadding:50];
        [self addChild:GOMenu];
    }
    return self;
}

-(void)RestartGame:(id)sender{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCW transitionWithDuration:.5 scene:[Game sceneWithLevelData:PlayersLevel mapWorldNum:PlayerWorld]]];
}
-(void)LoadLevelSelect:(id)sender{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    
    if(PlayerWorld <2){
        [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCCW transitionWithDuration:.5 scene:[WorldOneSelectLayer scene]]];
    } else {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCCW transitionWithDuration:.5 scene:[WorldTwoSelectLayer scene]]];
    }
}
-(void)LoadWorldSelect:(id)sender{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCCW transitionWithDuration:.5 scene:[WorldSelectLayer scene]]];
}
-(void)LoadMainMenu:(id)sender{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCCW transitionWithDuration:.5 scene:[MenuLayer scene]]];
}
-(void)onEnter{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCParticleSystem *particleSystem = [[CCParticleGalaxy alloc] initWithTotalParticles:500];
    particleSystem.position = ccp(winSize.width/2, winSize.height/2);
    [particleSystem setTexture:[[CCTextureCache sharedTextureCache] addImage:@"star.png"]];
    particleSystem.startColor = ccc4f(255, 0, 0, 255);
    particleSystem.gravity = ccp(0, 0);
    particleSystem.life = 5;
    particleSystem.lifeVar = 4;
    particleSystem.startSize = 1.0f;
    particleSystem.endSize = 6.0f;
    [self addChild:particleSystem z:-3];
    
    [super onEnter];
}

@end
