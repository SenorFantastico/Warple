//
//  CreditLayer.m
//  Warple
//
//  Created by Marc Frankel on 2/25/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//

#import "CreditLayer.h"

#import "SimpleAudioEngine.h"
#import "MenuLayer.h"



@implementation CreditLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CreditLayer *layer = [CreditLayer node];
   
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	
	// return the scene
	return scene;
}

-(void)MoveTextUp:(NSArray*)TextsToMove{
    
    for(CCNode* currentText in TextsToMove)
    {
        id actionToRepeat = [CCMoveBy actionWithDuration:0.03 position:ccp(0, 1)];
        id repeat = [CCRepeatForever actionWithAction:actionToRepeat];
        [currentText runAction:repeat];
    }
    
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    switch (touch.tapCount) {
        case 2:
            
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2 scene:[MenuLayer scene]]];
            break;
    }
}
-(void)update:(ccTime)delta{

    CCSprite *tempSprite = (CCSprite*)[self getChildByTag:444];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    if(tempSprite.position.y > winSize.height+20){
        [self unschedule:@selector(update:)];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:2 scene:[MenuLayer scene]]];
    }
}
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
}
- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
}

-(id)init{
    
    if (self=[super initWithColor:ccc4(255, 255, 255, 0)]) {
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCLabelTTF *Instructions = [CCLabelTTF labelWithString:@"Double tap to end early" fontName:@"Times New Roman" fontSize:25];
        
        
        Instructions.position = ccp(winSize.width/2,winSize.height/2);
        [self addChild:Instructions];
        [Instructions runAction:[CCFadeTo actionWithDuration:8 opacity:0.0f]];
        
        CCLabelTTF *header = [CCLabelTTF labelWithString:@"Warple" fontName:@"BD Cartoon Shout" fontSize:35];
        
        header.position = ccp(winSize.width/2, (winSize.height-80)-winSize.height);
        [self addChild:header];
        
        CCSprite *Icon =[CCSprite spriteWithFile:@"warple-icon_blue.png"];
        Icon.position = ccp(winSize.width/2, (winSize.height-125)-winSize.height);
        [self addChild:Icon];
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        CCLabelTTF *Version = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"v (%@)",majorVersion] fontName:@"Times New Roman" fontSize:18];
        
        Version.position =ccp(winSize.width/2, (winSize.height-165)-winSize.height);
        [self addChild:Version];
        
        
        CCLabelTTF *Coding = [CCLabelTTF labelWithString:@"Coding:" fontName:@"Times New Roman" fontSize:30];
        Coding.color = ccc3(0, 187, 53);
        Coding.position = ccp(winSize.width/2,(winSize.height-150)-winSize.height-50);
        [self addChild:Coding];
        CCLabelTTF *Coders = [CCLabelTTF labelWithString:@"• Marc Frankel\n• Craig Hinrichs" fontName:@"Times New Roman" fontSize:20];
        Coders.position = ccp(winSize.width/2,(winSize.height-190)-winSize.height-50);
        [self addChild:Coders];
        
        CCLabelTTF *Design = [CCLabelTTF labelWithString:@"Design:" fontName:@"Times New Roman" fontSize:30];
        Design.color = ccc3(0, 187, 53);
        Design.position = ccp(winSize.width/2,(winSize.height-240)-winSize.height-50);
        [self addChild:Design];
        CCLabelTTF *Designers = [CCLabelTTF labelWithString:@"• Marc Frankel\n• Craig Hinrichs\n• Danny Andreini" fontName:@"Times New Roman" fontSize:20];
        Designers.position = ccp(winSize.width/2,(winSize.height-290)-winSize.height-50);
        [self addChild:Designers];
        
        CCLabelTTF *Music = [CCLabelTTF labelWithString:@"Music:" fontName:@"Times New Roman" fontSize:30];
        Music.color = ccc3(0, 187, 53);
        
        Music.position = ccp(winSize.width/2,(winSize.height-350)-winSize.height-50);
        [self addChild:Music];
        
        CCLabelTTF *Musisions = [CCLabelTTF labelWithString:@"• Marcelo Cataldo" fontName:@"Times New Roman" fontSize:20];
        
        Musisions.position = ccp(winSize.width/2,(winSize.height-380)-winSize.height-50);
        [self addChild:Musisions];
        
        
        
        CCLabelTTF *Special = [CCLabelTTF labelWithString:@"Beta Testers:" fontName:@"Times New Roman" fontSize:30];
        Special.color = ccc3(0, 187, 53);
        Special.position = ccp(winSize.width/2,(winSize.height-420)-winSize.height-50);
        [self addChild:Special];
        
        
        CCLabelTTF *Special_Betas = [CCLabelTTF labelWithString:@"• Jimmy Abbott\n• John Bell\n• Will Christopherson\n• Tyler Dalton\n• Dunadel Daryoush\n• Donald Frankel\n• Mason Lovell\n• Alec Silver\n• Jacob Warhop" fontName:@"Times New Roman" fontSize:20];
        Special_Betas.position = ccp(winSize.width/2,(winSize.height-540)-winSize.height-50);
        [self addChild:Special_Betas];
        
        CCLabelTTF *SFIcon = [CCSprite spriteWithFile:@"SF_simple.png"];
        SFIcon.position = ccp(winSize.width/2,Special_Betas.position.y-175);
        [self addChild:SFIcon];
        
        CCLabelTTF *Made_By = [CCLabelTTF labelWithString:@"© Señor Fantástico Games\n \"Stay Fantástico!\"" fontName:@"Times New Roman" fontSize:30];
        Made_By.position = ccp(winSize.width/2,SFIcon.position.y  - 70);
        [self addChild:Made_By];
        
        
        
        Made_By.tag = 444;
        
        
        
        NSArray *ArrayOfCredits = [NSArray arrayWithObjects:header,Icon,Version,Coding,Coders,Design,Designers,Music,Musisions,Special,Special_Betas,SFIcon,Made_By, nil];
        
        [self MoveTextUp:ArrayOfCredits];
        [self schedule:@selector(update:) interval:1];
        
    }
    return self;
}
- (void) onExit{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}

@end
