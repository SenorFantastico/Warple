//
//  WorldTwoSelectLayer.m
//  Warple
//
//  Created by Marc Frankel on 3/5/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//

#import "WorldTwoSelectLayer.h"
#import "WorldSelectLayer.h"
#import "MenuLayer.h"
#import "Game.h"
#import "SimpleAudioEngine.h"

@implementation WorldTwoSelectLayer
@synthesize swipeRightRecognizer = _swipeRightRecognizer;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	WorldTwoSelectLayer*layer = [WorldTwoSelectLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(void)loadLevel:(id)sender {
    CCMenuItem* menuItem = (CCMenuItem*)sender;
    NSString *leveldatawhole = menuItem.userData;
    
    NSArray* splits = [leveldatawhole componentsSeparatedByString: @"."];
    int worldnumber = [[splits objectAtIndex:0] integerValue];
    int levelnumber = [[splits objectAtIndex:1] integerValue];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"button-21.mp3"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionProgressRadialCW transitionWithDuration:.5 scene:[Game sceneWithLevelData:worldnumber mapWorldNum:levelnumber]]];
}
-(void)PlaceGems:(NSMutableArray *)LevelMenuItems{
    NSUserDefaults *defualts = [NSUserDefaults standardUserDefaults];
    
    //[defualts setObject:@"0" forKey:@"GemsGained1.1"];
    
    for (CCMenuItemImage *levelMenuButton in LevelMenuItems){
        NSString *tempstring = [NSString stringWithFormat:@"GemsGained%@",levelMenuButton.userData];
        
        NSString *GemsAchievedOnLevel = [defualts objectForKey:tempstring];
        int GemsGained = [GemsAchievedOnLevel integerValue];
        CCSprite *Gem1;
        CCSprite *Gem2;
        CCSprite *Gem3;
        switch (GemsGained) {
            case 0:
                Gem1 = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1-D.png"]];
                Gem2 = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1-D.png"]];
                Gem3 = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1-D.png"]];
                
                [levelMenuButton addChild:Gem1];
                [levelMenuButton addChild:Gem2];
                [levelMenuButton addChild:Gem3];
                
                break;
            case 1:
                Gem1 = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1.png"]];
                Gem2 = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1-D.png"]];
                Gem3 = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1-D.png"]];
                
                [levelMenuButton addChild:Gem1];
                [levelMenuButton addChild:Gem2];
                [levelMenuButton addChild:Gem3];
                break;
            case 2:
                Gem1 = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1.png"]];
                Gem2 = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1.png"]];
                Gem3 = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1-D.png"]];
                
                [levelMenuButton addChild:Gem1];
                [levelMenuButton addChild:Gem2];
                [levelMenuButton addChild:Gem3];
                break;
            case 3:
                Gem1 = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1.png"]];
                Gem2 = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1.png"]];
                Gem3 = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"Gem-1.png"]];
                
                [levelMenuButton addChild:Gem1];
                [levelMenuButton addChild:Gem2];
                [levelMenuButton addChild:Gem3];
                break;
        }
        Gem1.position = ccp(levelMenuButton.contentSize.width*.1, levelMenuButton.contentSize.height*.3);
        Gem2.position = ccp(levelMenuButton.contentSize.width/2, levelMenuButton.contentSize.height*.15);
        Gem3.position = ccp(levelMenuButton.contentSize.width*.9, levelMenuButton.contentSize.height*.3);
        
    }
}
-(void)LoadLevelData:(NSMutableArray *)Levelarry{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    for (CCMenuItemImage *levelMenuButton in Levelarry) {
        NSString * leveldatawhole = levelMenuButton.userData;
        NSArray* splits = [leveldatawhole componentsSeparatedByString: @"."];
        int worldnumber = [[splits objectAtIndex:0] integerValue];
        int levelnumber = [[splits objectAtIndex:1] integerValue];
        
        NSString * temp = [NSString stringWithFormat:@"HasWon_%i.%i",worldnumber,levelnumber];
        
        NSString *PlayerLevelStatus = [defaults objectForKey:temp];
        
        
        if (PlayerLevelStatus == nil) {
            
            [levelMenuButton setIsEnabled:NO];
        }
    }
}

-(void)placeLevelSelect{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    BOOL isRetina;
    if ([[CCDirector sharedDirector] enableRetinaDisplay:YES] && winSize.height == 568)//Check For Retina
    {
        isRetina = YES;
        
    }else{
        isRetina = NO;
        
    }
    
    
    
    int static constantgap;
    if(isRetina){
        
        constantgap = 15;
    } else {
        constantgap = 0;
    }
    
    
    //
    //Row 1
    //
    CCMenuItem *Level1 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level1Label = [CCLabelTTF labelWithString:@"1" fontName:@"Danube" fontSize:30];
    Level1Label.position =ccp(Level1.contentSize.width/2, Level1.contentSize.height/2);
    [Level1 addChild:Level1Label];
    Level1.userData = (__bridge void *)(@"2.1");
    
    CCMenuItem *Level2 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level2Label = [CCLabelTTF labelWithString:@"2" fontName:@"Danube" fontSize:30];
    Level2Label.position =ccp(Level2.contentSize.width/2, Level2.contentSize.height/2);
    [Level2 addChild:Level2Label];
    Level2.userData = (__bridge void *)(@"2.2");
    
    CCMenuItem *Level3 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level3Label = [CCLabelTTF labelWithString:@"3" fontName:@"Danube" fontSize:30];
    Level3Label.position =ccp(Level3.contentSize.width/2, Level3.contentSize.height/2);
    [Level3 addChild:Level3Label];
    Level3.userData = (__bridge void *)(@"2.3");
    
    CCMenu *levelSelectRow1 = [CCMenu menuWithItems:Level1,Level2,Level3, nil];
    [levelSelectRow1 alignItemsHorizontallyWithPadding:20];
    levelSelectRow1.position = ccp(winSize.width/2,winSize.height-45-(1*constantgap));
    [self addChild:levelSelectRow1];
    //
    //End Row 1
    //
    //
    //Row 2
    //
    CCMenuItem *Level4 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level4Label = [CCLabelTTF labelWithString:@"4" fontName:@"Danube" fontSize:30];
    Level4Label.position =ccp(Level4.contentSize.width/2, Level4.contentSize.height/2);
    [Level4 addChild:Level4Label];
    Level4.userData = (__bridge void *)(@"2.4");
    
    CCMenuItem *Level5 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level5Label = [CCLabelTTF labelWithString:@"5" fontName:@"Danube" fontSize:30];
    Level5Label.position =ccp(Level5.contentSize.width/2, Level5.contentSize.height/2);
    [Level5 addChild:Level5Label];
    Level5.userData = (__bridge void *)(@"2.5");
    
    CCMenuItem *Level6 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level6Label = [CCLabelTTF labelWithString:@"6" fontName:@"Danube" fontSize:30];
    Level6Label.position =ccp(Level6.contentSize.width/2, Level6.contentSize.height/2);
    [Level6 addChild:Level6Label];
    Level6.userData = (__bridge void *)(@"2.6");
    
    CCMenu *levelSelectRow2 = [CCMenu menuWithItems:Level4,Level5,Level6, nil];
    [levelSelectRow2 alignItemsHorizontallyWithPadding:20];
    levelSelectRow2.position = ccp(winSize.width/2,winSize.height-140-(2*constantgap));
    [self addChild:levelSelectRow2];
    //
    //End Row 2
    //
    //
    //Row 3
    //
    CCMenuItem *Level7 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level7Label = [CCLabelTTF labelWithString:@"7" fontName:@"Danube" fontSize:30];
    Level7Label.position =ccp(Level7.contentSize.width/2, Level7.contentSize.height/2);
    [Level7 addChild:Level7Label];
    Level7.userData = (__bridge void *)(@"2.7");
    
    CCMenuItem *Level8 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level8Label = [CCLabelTTF labelWithString:@"8" fontName:@"Danube" fontSize:30];
    Level8Label.position =ccp(Level8.contentSize.width/2, Level8.contentSize.height/2);
    [Level8 addChild:Level8Label];
    Level8.userData = (__bridge void *)(@"2.8");
    
    CCMenuItem *Level9 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level9Label = [CCLabelTTF labelWithString:@"9" fontName:@"Danube" fontSize:30];
    Level9Label.position =ccp(Level9.contentSize.width/2, Level9.contentSize.height/2);
    [Level9 addChild:Level9Label];
    Level9.userData = (__bridge void *)(@"2.9");
    
    CCMenu *levelSelectRow3 = [CCMenu menuWithItems:Level7,Level8,Level9, nil];
    [levelSelectRow3 alignItemsHorizontallyWithPadding:20];
    levelSelectRow3.position = ccp(winSize.width/2,winSize.height-235-(3*constantgap));
    [self addChild:levelSelectRow3];
    //
    //End Row 3
    //
    //
    //Row 4
    //
    CCMenuItem *Level10 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level10Label = [CCLabelTTF labelWithString:@"10" fontName:@"Danube" fontSize:30];
    Level10Label.position =ccp(Level10.contentSize.width/2, Level10.contentSize.height/2);
    [Level10 addChild:Level10Label];
    Level10.userData = (__bridge void *)(@"2.10");
    
    CCMenuItem *Level11 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level11Label = [CCLabelTTF labelWithString:@"11" fontName:@"Danube" fontSize:30];
    Level11Label.position =ccp(Level11.contentSize.width/2, Level11.contentSize.height/2);
    [Level11 addChild:Level11Label];
    Level11.userData = (__bridge void *)(@"2.11");
    
    CCMenuItem *Level12 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level12Label = [CCLabelTTF labelWithString:@"12" fontName:@"Danube" fontSize:30];
    Level12Label.position =ccp(Level12.contentSize.width/2, Level12.contentSize.height/2);
    [Level12 addChild:Level12Label];
    Level12.userData = (__bridge void *)(@"2.12");
    
    CCMenu *levelSelectRow4 = [CCMenu menuWithItems:Level10,Level11,Level12, nil];
    [levelSelectRow4 alignItemsHorizontallyWithPadding:20];
    levelSelectRow4.position = ccp(winSize.width/2,winSize.height-330-(4*constantgap));
    [self addChild:levelSelectRow4];
    //
    //End Row 4
    //
    //
    //Row 5
    //
    CCMenuItem *Level13 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level13Label = [CCLabelTTF labelWithString:@"13" fontName:@"Danube" fontSize:30];
    Level13Label.position =ccp(Level13.contentSize.width/2, Level13.contentSize.height/2);
    [Level13 addChild:Level13Label];
    Level13.userData = (__bridge void *)(@"2.13");
    
    CCMenuItem *Level14 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level14Label = [CCLabelTTF labelWithString:@"14" fontName:@"Danube" fontSize:30];
    Level14Label.position =ccp(Level14.contentSize.width/2, Level14.contentSize.height/2);
    [Level14 addChild:Level14Label];
    Level14.userData = (__bridge void *)(@"2.14");
    
    CCMenuItem *Level15 = [CCMenuItemImage itemWithNormalImage:@"Level_button_-U.png" selectedImage:@"Level_button_-D.png" disabledImage:@"Level_button_-DS.png"  target:self selector:@selector(loadLevel:)];
    CCLabelTTF *Level15Label = [CCLabelTTF labelWithString:@"15" fontName:@"Danube" fontSize:30];
    Level15Label.position =ccp(Level15.contentSize.width/2, Level15.contentSize.height/2);
    [Level15 addChild:Level15Label];
    Level15.userData = (__bridge void *)(@"2.15");
    
    CCMenu *levelSelectRow5 = [CCMenu menuWithItems:Level13,Level14,Level15, nil];
    [levelSelectRow5 alignItemsHorizontallyWithPadding:20];
    levelSelectRow5.position = ccp(winSize.width/2,winSize.height-425-(5*constantgap));
    [self addChild:levelSelectRow5];
    //
    //End Row 4
    //
    
    NSMutableArray *levels = [NSMutableArray arrayWithObjects:Level1,Level2,Level3,Level4,Level5,Level6,Level7,Level8,Level9,Level10,Level11,Level12,Level13,Level14,Level15, nil];
    [self LoadLevelData:levels];
    [self PlaceGems:levels];
    
}

-(id)init{
    
    if(self=[super initWithColor:ccc4(255, 255, 255, 0)])
    {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"button-21.mp3"];
        
        [self placeLevelSelect];
        
        CCParticleSystem *particleSystem = [[CCParticleGalaxy alloc] initWithTotalParticles:500];
        particleSystem.position = ccp(winSize.width/2, winSize.height/2);
        [particleSystem setTexture:[[CCTextureCache sharedTextureCache] addImage:@"star.png"]];
        particleSystem.gravity = ccp(0, 0);
        particleSystem.life = 5;
        particleSystem.lifeVar = 4;
        particleSystem.startSize = 1.0f;
        particleSystem.endSize = 6.0f;
        [self addChild:particleSystem z:-3];
        
    }
    return self;
}
-(void)handleRightSwipe:(id)sender{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:.5 scene:[WorldSelectLayer scene]]];
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
