//
//  Helper.h
//  EvilGreenMen
//
//  Created by Craig Hinrichs on 3/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef EvilGreenMen_Helper_h
#define EvilGreenMen_Helper_h
bool pointIsInRect(CGPoint p, CGRect r){
	bool isInRect = false;
	if( p.x < r.origin.x + r.size.width && 
	   p.x > r.origin.x &&
	   p.y < r.origin.y + r.size.height &&
	   p.y > r.origin.y )
	{
		isInRect = true;
	}
	return isInRect;
}

bool pointIsInCircle(CGPoint p, CGPoint origin, float radius){
	bool isInCircle = false;
	if(ccpDistance(p, origin) <= radius){
		isInCircle = true;
	}
	return isInCircle;
}
float radiansToDegrees(float r){
	return r * (180/M_PI);
}
float vectorToRadians(CGPoint vector){
	if(vector.y == 0){ vector.y = 0.000001f; }
	float baseRadians = atan(vector.x/vector.y);
	if(vector.y < 0){ baseRadians += M_PI; }	//Adjust for -Y
	return baseRadians;
}
CGPoint radiansToVector(float radians){
	return ccp(sin(radians-M_PI/2), cos(radians-M_PI/2));
}
#endif
