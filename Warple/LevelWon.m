//
//  LevelWon.m
//  Warple
//
//  Created by Marc Frankel on 3/24/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//

#import "LevelWon.h"
#import "Game.h"
#import "SimpleAudioEngine.h"
#import "MenuLayer.h"


@implementation LevelWon
@synthesize state = _state, adWhirlView;

+(CCScene *) sceneWithData:(int)levelNum mapWorldNum:(int)mapWorldNum timeLeft:(int)timeLeft totalTime:(int)totalTime gemsCollected:(int)gemsCollected otherGems:(int)otherGems totalOtherGems:(int)totalOtherGems
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LevelWon *layer = [[LevelWon node] initWithData:levelNum mapWorldNum:mapWorldNum timeLeft:timeLeft totalTime:totalTime gemsCollected:gemsCollected otherGems:otherGems totalOtherGems:totalOtherGems];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(void)LoadMainMenu:(id)sender{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCCW transitionWithDuration:.5 scene:[MenuLayer scene]]];
}
-(void)Replay:(id)sender{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCW transitionWithDuration:.5 scene:[Game sceneWithLevelData:PlayersLevel mapWorldNum:PlayersWorld]]];
}
-(void)NextLevel:(id)sender{
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    if(PlayersLevel <15){
    [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCW transitionWithDuration:.5 scene:[Game sceneWithLevelData:PlayersLevel+1 mapWorldNum:PlayersWorld]]];
    } else if (PlayersLevel == 15 && PlayersWorld == 1){
        [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCW transitionWithDuration:.5 scene:[Game sceneWithLevelData:1 mapWorldNum:PlayersWorld+1]]];
    } else if (PlayersLevel == 15 && PlayersWorld > 1){
        //Player has beaten game
    }
}

-(id)initWithData:(int)levelNum mapWorldNum:(int)mapWorldNum timeLeft:(int)timeLeft totalTime:(int)totalTime gemsCollected:(int)gemsCollected otherGems:(int)otherGems totalOtherGems:(int)totalOtherGems{
    
    if (self==[super initWithColor:ccc4(255, 255, 255, 255)]) {
        CGSize winsize = [[CCDirector sharedDirector] winSize];
        PlayersLevel = levelNum;
        PlayersWorld = mapWorldNum;
        
        CCLabelTTF *Time = [CCLabelTTF labelWithString:@"Time:" fontName:@"ArtBrush" fontSize:30];
        Time.position = ccp((winsize.width*.5)-(Time.contentSize.width/2), winsize.height*.7);
        [self addChild:Time z:1];
        
        CCLabelTTF *TimeData = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i/%i ",timeLeft,totalTime] fontName:@"ArtBrush" fontSize:30];
        TimeData.position = ccp((winsize.width*.7)+(TimeData.contentSize.width/2), winsize.height*.7);
        [self addChild:TimeData z:1];
        
        CCLabelTTF *TimeBonus = [CCLabelTTF labelWithString:@"Time Bonus:" fontName:@"ArtBrush" fontSize:30];
        TimeBonus.position = ccp((winsize.width*.5)-(TimeBonus.contentSize.width/2), Time.position.y-40);
        [self addChild:TimeBonus z:1];
        
        int TimeBonusScore = timeLeft*7;
        
        CCLabelTTF *TimeBonusData = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i ",TimeBonusScore] fontName:@"ArtBrush" fontSize:30];
        TimeBonusData.position = ccp((winsize.width*.7)+(TimeBonusData.contentSize.width/2), TimeData.position.y-40);
        [self addChild:TimeBonusData z:1];
        
        CCLabelTTF *GemsLabel = [CCLabelTTF labelWithString:@"Gems:" fontName:@"ArtBrush" fontSize:30];
        
        GemsLabel.position = ccp((winsize.width*.5)-(GemsLabel.contentSize.width/2), TimeBonus.position.y-40);
        [self addChild:GemsLabel z:1];
        
        Gem1 = [CCSprite spriteWithFile:@"Gem-1-D.png"];
        Gem2 = [CCSprite spriteWithFile:@"Gem-1-D.png"];
        Gem3 = [CCSprite spriteWithFile:@"Gem-1-D.png"];
         
        Gem1.position = ccp((winsize.width*.7 + Gem1.contentSize.width*1.5), TimeBonusData.position.y-40);
        
        Gem2.position = ccp(Gem1.position.x-Gem2.contentSize.width/2, TimeBonusData.position.y-40);
        
        Gem3.position = ccp(Gem2.position.x-Gem3.contentSize.width/2, TimeBonusData.position.y-40);
        
        [self addChild:Gem1 z:9];
        [self addChild:Gem2 z:8];
        [self addChild:Gem3 z:7];
        
        for (int c = 0; c<=gemsCollected; c++) {
            if(c==1){
                [Gem3 setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1.png"]];
            } else if(c==2){
                [Gem2 setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1.png"]];
            } else if(c==3){
                [Gem1 setTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1.png"]];
            }
        }
        
        CCLabelTTF *OtherGemsLabel = [CCLabelTTF labelWithString:@"Other Gems:" fontName:@"ArtBrush" fontSize:30];
        OtherGemsLabel.position = ccp((winsize.width*.5)-(OtherGemsLabel.contentSize.width/2), GemsLabel.position.y-40);
        [self addChild:OtherGemsLabel z:1];
        
        CCLabelTTF *OtherGemsData = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i/%i ",otherGems,totalOtherGems] fontName:@"ArtBrush" fontSize:30];
        OtherGemsData.position = ccp((winsize.width*.7)+(OtherGemsData.contentSize.width/2), Gem1.position.y-40);
        [self addChild:OtherGemsData z:1];
        
        CCLabelTTF *GemBonus = [CCLabelTTF labelWithString:@"Gem Score:" fontName:@"ArtBrush" fontSize:30];
        GemBonus.position = ccp((winsize.width*.5)-(GemBonus.contentSize.width/2), OtherGemsLabel.position.y-40);
        [self addChild:GemBonus z:1];
        
        int GemBonusScore = (otherGems*10)+(gemsCollected*300);
        CCLabelTTF *GemBonusData = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i ",GemBonusScore] fontName:@"ArtBrush" fontSize:30];
        GemBonusData.position = ccp((winsize.width*.7)+(GemBonusData.contentSize.width/2), OtherGemsData.position.y-40);
        [self addChild:GemBonusData z:1];
        
        CCLabelTTF *FinalScoreLabel = [CCLabelTTF labelWithString:@"Final Score:" fontName:@"ArtBrush" fontSize:30];
        FinalScoreLabel.position = ccp((winsize.width*.5)-(FinalScoreLabel.contentSize.width/2), GemBonus.position.y-40);
        [self addChild:FinalScoreLabel z:1];
        
        CCLabelTTF *FinalScoreData = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i ",TimeBonusScore+GemBonusScore] fontName:@"ArtBrush" fontSize:30];
        FinalScoreData.position = ccp((winsize.width*.7)+(FinalScoreData.contentSize.width/2), GemBonusData.position.y-40);
        [self addChild:FinalScoreData z:1];
        
        
        CCMenuItem *MainMenu = [CCMenuItemImage itemWithNormalImage:@"Level_Won_Main_Menu-U.png" selectedImage:@"Level_Won_Main_Menu-D.png" target:self selector:@selector(LoadMainMenu:)];
        CCMenuItem *Replay = [CCMenuItemImage itemWithNormalImage:@"Level_Won_Replay-U.png" selectedImage:@"Level_Won_Replay-D.png" target:self selector:@selector(Replay:)];
        CCMenuItem *NextLevel = [CCMenuItemImage itemWithNormalImage:@"Level_Won_Next_Level-U.png" selectedImage:@"Level_Won_Next_Level-D.png" target:self selector:@selector(Nextlevel:)];
        
        CCMenu *ButtonMenu = [CCMenu menuWithItems:MainMenu,Replay,NextLevel, nil];
        [ButtonMenu alignItemsHorizontallyWithPadding:(winsize.width-MainMenu.contentSize.width*3)/3];
        [self addChild:ButtonMenu z:1];
        ButtonMenu.position =ccp(winsize.width/2, winsize.height*.2);
         
        
        NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
         NSString *tempstring = [NSString stringWithFormat:@"GemsGained%i.%i",PlayersWorld,PlayersLevel];
        if([defualts integerForKey:tempstring] < gemsCollected || [defualts integerForKey:tempstring] == 0){
            NSLog(@"Set Gems");
            [defualts setInteger:gemsCollected forKey:tempstring];
            //[defualts setInteger:0 forKey:tempstring]; // reset gems for level
        }
        
        if(PlayersLevel < 15){
            NSLog(@"Unlocked next level in this world");
            NSString *nextlevelUnlock = [NSString stringWithFormat:@"HasWon_%i.%i",PlayersWorld,PlayersLevel+1];
            [defualts setObject:@"True" forKey:nextlevelUnlock];
            
        } else if (PlayersLevel == 15 && PlayersWorld == 1){
            NSLog(@"Unlock first level in a new world");
            NSString *nextlevelUnlock = [NSString stringWithFormat:@"HasWon_%i.%i",2,1];
            [defualts setObject:@"True" forKey:nextlevelUnlock];
            
        } else if (PlayersLevel == 15 && PlayersWorld == 2){
            NSLog(@"Player won");
            //Player has beaten game
        }
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return self;
}
-(void)adWhirlWillPresentFullScreenModal {
   
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
        [[CCDirector sharedDirector] pause];
}
-(void)adWhirlDidDismissFullScreenModal {
    
        [[CCDirector sharedDirector] resume];
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
        
}
- (NSString *)adWhirlApplicationKey {
    return @"1c97032af27c424ea2fc0b3dd599dd41";
}
- (UIViewController *)viewControllerForPresentingModalView {
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    UINavigationController *viewController = [app navController];
    return viewController;
}
-(void)adjustAdSize {
    [UIView beginAnimations:@"AdResize" context:nil];
    [UIView setAnimationDuration:0.2];
    CGSize adSize = [adWhirlView actualAdSize];
    CurrentAdHeight = adSize;
    CGRect newFrame = adWhirlView.frame;
    newFrame.size.height = adSize.height;
    CGSize winSize = [CCDirector sharedDirector].winSize;
    newFrame.size.width = winSize.width;
    newFrame.origin.x = (self.adWhirlView.bounds.size.width - adSize.width)/2;
    newFrame.origin.y = (winSize.height -adSize.height);
    adWhirlView.frame = newFrame;
    
    
    [UIView commitAnimations];
    
    NSLog(@"Ad from:%@",[adWhirlView mostRecentNetworkName]);
}
-(void)adWhirlDidReceiveAd:(AdWhirlView *)adWhirlVieww {
    [adWhirlVieww rotateToOrientation:UIInterfaceOrientationPortraitUpsideDown];
    [self adjustAdSize];
}
-(void)onEnter{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *background = [CCSprite spriteWithFile:@"LevelWonBackground.png"];
    background.position = ccp(size.width/2, size.height/2);
    [self addChild:background];
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    UINavigationController *viewController = [app navController];
    self.adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
    //self.adWhirlView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    [adWhirlView updateAdWhirlConfig];
    CGSize adSize = [adWhirlView actualAdSize];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    self.adWhirlView.frame = CGRectMake((winSize.width/2)-(adSize.width/2), winSize.height-adSize.height, winSize.width, adSize.height);
    self.adWhirlView.clipsToBounds = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"A0843A138E93C609FC292486D9BB40FE"]) {
        NSLog(@"No Ads for this awesome guy!");
        CCSprite *Adreplacement = [CCSprite spriteWithFile:@"AdReplace.png"];
        [self addChild:Adreplacement z:30];
        Adreplacement.position = ccp(winSize.width/2, Adreplacement.contentSize.height/2);
        
    } else {
        [viewController.view addSubview:adWhirlView];
        [viewController.view bringSubviewToFront:adWhirlView];
    }
    [super onEnter];
}

-(void)onExit {
    
    if(adWhirlView) {
        [adWhirlView removeFromSuperview];
        [adWhirlView replaceBannerViewWith:nil];
        [adWhirlView ignoreNewAdRequests];
        [adWhirlView setDelegate:nil];
        self.adWhirlView = nil;
    }
    
    [super onExit];
}

@end
