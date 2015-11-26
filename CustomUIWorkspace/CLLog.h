//
//  CLLog.h
//  HiLib
//  Created by Sean Li on 4/3/14.
//  Copyright (c) 2014 你好！开源. All rights reserved.
//
//  @see https://github.com/lixuanxian/XcodeColors




#define XCODE_COLORS_ESCAPE @"\033["
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color
#define DDLogRedColor  @"255,0,0;"
#define DDLogGrayColor @"125,125,125;"
#define DDLogBlackColor @"0,0,0;"
#define DDLogWhitColor @"255,255,255;"
#define DDLogOrangeColor @"255,255,0;"
#define DDLogBlueColor @"131,201,153;"


#define _CLLog(info,fmt,bgColor,fgColor, ...) NSLog((XCODE_COLORS_ESCAPE  @"bg" bgColor XCODE_COLORS_ESCAPE @"fg" fgColor info XCODE_COLORS_RESET fmt @"\n%s [Line:%d]  " @"\n"),##__VA_ARGS__,__PRETTY_FUNCTION__,__LINE__)

 
#ifdef DEBUG

#define CL_INFO(fmt, ...)     _CLLog(@"=========== INFO ===========",fmt,DDLogWhitColor,DDLogGrayColor,##__VA_ARGS__)
#define CL_WARN(fmt, ...)     _CLLog(@"!!========= WARN =========!!",fmt,DDLogOrangeColor,DDLogBlackColor,##__VA_ARGS__)
#define CL_ERROR(fmt, ...)    _CLLog(@"!!!======== ERROR =========!!!",fmt,DDLogRedColor,DDLogBlackColor,##__VA_ARGS__)
#define CL_DEBUG(fmt, ...)    _CLLog(@"!========== DEBUG ==========!",fmt,DDLogGrayColor,DDLogWhitColor,##__VA_ARGS__)

#else

#define CL_INFO(fmt, ...)  ((void)0)
#define CL_WARN(fmt, ...) ((void)0)
#define CL_ERROR(fmt, ...) ((void)0)
#define CL_DEBUG(fmt, ...) ((void)0)

#endif

