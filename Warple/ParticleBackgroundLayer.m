//
//  ParticleBackgroundLayer.m
//  Warple
//
//  Created by Marc Frankel on 3/1/13.
//  Copyright 2013 Señor Fantástico Games. All rights reserved.
//

#import "ParticleBackgroundLayer.h"


@implementation ParticleBackgroundLayer

-(id)init{
    if (self == [super init]) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        particleSystem = [[CCParticleGalaxy alloc] initWithTotalParticles:500];
        particleSystem.position = ccp(winSize.width/2, winSize.height/2);
        [particleSystem setTexture:[[CCTextureCache sharedTextureCache] addImage:@"star.png"]];
        particleSystem.gravity = ccp(0, 0);
        particleSystem.life = 5;
        particleSystem.lifeVar = 4;
        particleSystem.startSize = 1.0f;
        particleSystem.endSize = 6.0f;
        [self addChild:particleSystem];
        
    }
    return self;
}

@end
