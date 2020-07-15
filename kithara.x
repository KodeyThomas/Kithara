//
//  kithara.x
//  kithara
//
//  Created by Kodey Thomas on 14/07/2020
//  Copyright Kodey Thomas All rights reserved.
//
//

//
// Foreword
// Upon Compilling, Please Attach a VALID LastFM API Key or this tweak WON'T work
//

//
// Special Thanks
// https://github.com/iCrazeiOS - Couldn't be bothered to search for the method to change the Carrier, thanks for the classname lol
//

// Imports
#import "apiCall/apiCall.h"
#import "STMutableTelephonySubscriptionInfo.h"
#import <Cephei/HBPreferences.h>
// End Imports

// Start Variables
BOOL isEnabled = NO;
NSMutableString *lastFM_Name;
NSString *API_KEY = @"API_KEY"; // Replace With A Valid LastFM API Key or this Tweak **WON'T** Work
// END Vairables

// Start HOOK
%hook STMutableTelephonySubscriptionInfo
-(void)setOperatorName:(NSString *)arg1 {

	// Start UNIX
	long long yesterdayUNIX = (long long)([[NSDate date] timeIntervalSince1970] - 86400); // Get The Exact Time 24hrs ago (UNIX)
	NSString *yesterdayUNIX_ = [NSString stringWithFormat:@"%lld", yesterdayUNIX];        // Convert it to a NSString
	// END UNIX

	// Start API Call
	NSString *POSTurl = @"http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks"; // API Call URL
	NSString *params = [NSString stringWithFormat:@"&user=%@&from=%@&limit=200&api_key=%@&format=json", lastFM_Name, yesterdayUNIX_, API_KEY];
	NSMutableDictionary *API_Response = [[apiCall sharedInstance] POST_JSON:POSTurl :params]; // Sends a POST request to the LastFM API and it returns all the songs played since yesterday
	// End API Call

	@try {
	// Start JSON Handling
	NSDictionary *recenttracks = API_Response[@"recenttracks"];
	NSDictionary *attr = recenttracks[@"@attr"];
	NSMutableString *totalScrobbles = [attr objectForKey:@"total"];  // Saves The Total Amount Of Scrobbles In A Variable
	// END JSON Handling

	// Carrier String
	NSMutableString *scrobbleText = @"Scrobbles: ";
	NSMutableString *customCarrierName = [scrobbleText stringByAppendingString:totalScrobbles];
	// END Carrier String
	%orig(customCarrierName);
	}

	// Execption Handling
	@catch (NSException *exception) {
		return %orig; // Don't Update Carrier, Due to Invalid Data (Will Cause Repspring)
	}
	// End Exception Handling
}
%end
// END HOOK

// Start HOOK
%hook SBControlCenterController
-(void)_didDismiss { // Triggers When Control Centre is Dismissed
	NSString *lol = @"Kithara";    																												              // When the Control Centre gets dismissed
	STMutableTelephonySubscriptionInfo *Telephony = [[STMutableTelephonySubscriptionInfo alloc] init];  // Trigger the Method to update the Carrier Name
	[Telephony setOperatorName:lol];                                                                    // Run the original code for _didDismiss
	%orig;                                                                                              // (Otherwise will not delete UIViews and you can't use certain apps)
}
%end
// END HOOK

// Start Prefs
%ctor {
  HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"tech.kodeycodesstuff.kitharaprefs"];
  [preferences registerBool:&isEnabled default:YES forKey:@"isEnabled"];
  [preferences registerObject:&lastFM_Name default:@"user" forKey:@"lastFM_Name"];
	NSLog(@"bruh: %@", lastFM_Name);
}
// End Prefs

// END OF FILE
