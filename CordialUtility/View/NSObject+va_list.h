//
//  NSObject+va_list.h
//
//  Created by WeiHan on 2/23/16.
//  Copyright © 2016 WeiHan. All rights reserved.
//
//  This main method +(void)apply:forObjects: is mainly used for apply some
//      uniform properties and behaviours for specified objects.
//  The internal implementation uses va_list for element collection, if your
//      collection type is NSArray/NSSet, etc, the prefer alternative method
//      is bk_each/bk_apply from BlocksKit
//      ( https://github.com/zwaldowski/BlocksKit/ ) .
//
//  The macro APPLY is a prefer usage for you.
//
//  Here is an available code snippet for macro, create a .codesnippet file
//      with the following content and move it into
//      ~/Library/Developer/Xcode/UserData/CodeSnippets, enjoy in Xcode!
//

/*
   -----------------------------------------------------------------------------
   -------------- Code Snippet File Content For Macro APPLY_UIOBJ --------------
   ----------------------------------- BEGIN -----------------------------------
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
        <key>IDECodeSnippetCompletionPrefix</key>
        <string>aly_obj</string>
        <key>IDECodeSnippetCompletionScopes</key>
        <array>
        <string>CodeBlock</string>
        </array>
        <key>IDECodeSnippetContents</key>
        <string> APPLY(^(id obj) {
            &lt;#code#&gt;
            }, &lt;#view#&gt;, nil);
        </string>
        <key>IDECodeSnippetIdentifier</key>
        <string>4A0A057B-8C17-43BB-BDBA-3A315A942EF8</string>
        <key>IDECodeSnippetLanguage</key>
        <string>Xcode.SourceCodeLanguage.Objective-C</string>
        <key>IDECodeSnippetTitle</key>
        <string>NSObject+valist Apply Macro</string>
        <key>IDECodeSnippetUserSnippet</key>
        <true/>
        <key>IDECodeSnippetVersion</key>
        <integer>2</integer>
   </dict>
   </plist>

   ------------------------------------ END ------------------------------------
 */

#import <Foundation/Foundation.h>

// The BlocksKit define the same name macro without prefix there, let's remap it here!
#ifdef APPLY
#undef APPLY
#endif

#define APPLY(__block, ...)  \
    [NSObject apply: __block \
 forObjects: __VA_ARGS__, nil]


@interface NSObject (va_list)

+ (void)apply:(void (^)(id))block forObjects:(id)firstObject, ...NS_REQUIRES_NIL_TERMINATION;

@end
