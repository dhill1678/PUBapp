/*==============================
 
 - WazzUp -
 
 Chat App Template made by FV iMAGINATION - 2015
 for codecanyon.net
 
===============================*/


#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]

#define		DEFAULT_TAB 0



#define     INVITE_FRIENDS_MESSAGE  @"Become A Pickup Legend! Track your Pickup Game Stats using the Pickup Stats app by AppMuumba. Download here: https://itunes.apple.com/us/artist/appmuumba/id871587578" // Invitation Message

#define     PARSE_APP_ID @"XiWunV1TmMWeHYCkBT9dztgEdRSzhKjPzGvwUj0s"        // Parse ID
#define     PARSE_CLIENT_KEY @"21TjbxCfi8V9ITUm476gZrn5uRxi99pcdtbFayFH"    // Parse Client Key


/*=========================================================================*/

///////////////
// User Info //
///////////////

#define		PF_INSTALLATION_CLASS_NAME			@"_Installation"		//	Class name
#define		PF_INSTALLATION_OBJECTID			@"objectId"				//	String
#define		PF_INSTALLATION_USER				@"user"					//	Pointer to User Class

#define		PF_USER_CLASS_NAME					@"_User"				//	Class name
#define		PF_USER_OBJECTID					@"objectId"				//	String
#define		PF_USER_USERNAME					@"username"				//	String
#define		PF_USER_PASSWORD					@"password"				//	String
#define		PF_USER_EMAIL						@"email"				//	String
#define		PF_USER_PHONE						@"phone"				//	String
#define		PF_USER_STATUS						@"status"				//	String

#define		PF_USER_EMAILCOPY					@"emailCopy"			//	String
#define		PF_USER_FULLNAME					@"fullname"				//	String
#define		PF_USER_FULLNAME_LOWER				@"fullname_lower"		//	String
#define		PF_USER_FACEBOOKID					@"facebookId"			//	String
#define		PF_USER_PICTURE						@"picture"				//	File
#define		PF_USER_THUMBNAIL					@"thumbnail"			//	File
#define		PF_USER_HOMECITY					@"homecity"				//	String
#define		PF_USER_HOMESTATE					@"homestate"            //	String
#define		PF_USER_HEIGHT                      @"height"				//	String
#define		PF_USER_WEIGHT                      @"weight"				//	String
#define		PF_USER_BIRTHDAY                    @"birthday"				//	String
#define		PF_USER_POSITION                    @"position"				//	String
#define		PF_USER_SCHOOL                      @"school"				//	String
#define		PF_USER_NICKNAME                    @"nickname"				//	String


//////////////
// Messages //
//////////////

#define		PF_CHAT_CLASS_NAME					@"Chat"					//	Class name
#define		PF_CHAT_USER						@"user"					//	Pointer to User Class
#define		PF_CHAT_ROOMID						@"roomId"				//	String
#define		PF_CHAT_TEXT						@"text"					//	String
#define		PF_CHAT_PICTURE						@"picture"				//	File
#define		PF_CHAT_VIDEO						@"video"				//	File
#define		PF_CHAT_CREATEDAT					@"createdAt"			//	Date

#define		PF_CHATROOMS_CLASS_NAME				@"ChatRooms"			//	Class name
#define		PF_CHATROOMS_NAME					@"name"					//	String

#define		PF_GROUP_NAME					    @"groupName"			//	String

#define		PF_MESSAGES_CLASS_NAME				@"Messages"				//	Class name
#define		PF_MESSAGES_USER					@"user"					//	Pointer to User Class
#define		PF_MESSAGES_ROOMID					@"roomId"				//	String
#define		PF_MESSAGES_DESCRIPTION				@"description"			//	String
#define		PF_MESSAGES_LASTUSER				@"lastUser"				//	Pointer to User Class
#define		PF_MESSAGES_LASTMESSAGE				@"lastMessage"			//	String
#define		PF_MESSAGES_COUNTER					@"counter"				//	Number
#define		PF_MESSAGES_UPDATEDACTION			@"updatedAction"		//	Date

#define		NOTIFICATION_APP_STARTED			@"NCAppStarted"
#define		NOTIFICATION_USER_LOGGED_IN			@"NCUserLoggedIn"
#define		NOTIFICATION_USER_LOGGED_OUT		@"NCUserLoggedOut"


////////////////
// User Stats //
////////////////

#define		PF_PRACTICE_CLASS_NAME				@"Practice"             //	Class name
#define		PF_PRACTICE_USER					@"user"					//	Pointer to User Class
#define		PF_PRACTICE_TYPE					@"type"                 //	String
#define		PF_PRACTICE_ZONE					@"zone"                 //	String
#define		PF_PRACTICE_MAKES					@"makes"                //	String
#define		PF_PRACTICE_ATTEMPTS				@"attempts"             //	String
#define		PF_PRACTICE_CONSECUTIVE				@"consecutive"          //	String
#define		PF_PRACTICE_COURTSTYLE				@"courtstyle"           //	String

#define		PF_GAME_CLASS_NAME                  @"Game"                 //	Class name
#define		PF_GAME_USER                        @"user"                 //	Pointer to User Class
#define		PF_GAME_TYPE                        @"type"                 //	String
#define		PF_GAME_SEASONID                    @"seasonid"             //	String
#define		PF_GAME_FULLCOURT                   @"fullcourt"            //	String
#define		PF_GAME_TEAMSIZE                    @"teamsize"             //	String
#define		PF_GAME_SCORINGSTYLE                @"scoringstyle"         //	String
#define		PF_GAME_YOURSCORE                   @"yourscore"            //	String
#define		PF_GAME_OPPONENTSCORE               @"opponentscore"        //	String
#define		PF_GAME_GAMEWINNER                  @"gamewinner"           //	String
#define		PF_GAME_TWOPTMADE                   @"twoptmade"            //	String
#define		PF_GAME_TWOPTATTEMPTED              @"twoptattempted"       //	String
#define		PF_GAME_THREEPTMADE                 @"threeptmade"          //	String
#define		PF_GAME_THREEPTATTEMPTED			@"threeptattempted"     //	String
#define		PF_GAME_FREETHROWMADE               @"freethrowmade"        //	String
#define		PF_GAME_FREETHROWATTEMPTED			@"freethrowattempted"   //	String
#define		PF_GAME_ASSISTS                     @"assists"              //	String
#define		PF_GAME_TURNOVERS                   @"turnovers"            //	String
#define		PF_GAME_OFFREBOUNDS                 @"offrebounds"          //	String
#define		PF_GAME_STEALS                      @"steals"               //	String
#define		PF_GAME_BLOCKS                      @"blocks"               //	String
#define		PF_GAME_DEFREBOUNDS                 @"defrebounds"          //	String
#define		PF_GAME_TOTALREBOUNDS               @"totalrebounds"        //	String
#define		PF_GAME_WIN                         @"win"                  //	String
