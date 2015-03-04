# SVProgressHUD

`SVProgressHUD` is a clean and powerful HUD tool meant to display crucial information for the user, the progress of an ongoing task, or to present a set of options for the user to choose from.

## Installation

* Drag the `SVProgressHUD/SVProgressHUD` folder into your project.
* Take care that `SVProgressHUD.bundle` is added to `Targets->Build Phases->Copy Bundle Resources`.
* Add the **QuartzCore** framework to your project.

## Usage

(see sample Xcode project in `/Demo`)

`SVProgressHUD` is created as a singleton (i.e. it doesn't need to be explicitly allocated and instantiated; you directly call `[SVProgressHUD method]`).

**Use `SVProgressHUD` wisely! Only use it if you absolutely need to perform a task before taking the user forward. Bad use case examples: pull to refresh, infinite scrolling, sending message.**

Using `SVProgressHUD` in your app will usually look as simple as this (using Grand Central Dispatch):

```objective-c
[SVProgressHUD show];
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    // time-consuming task
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
});
```

### Showing the HUD

You can show the status of indeterminate tasks using one of the following:

```objective-c
+ (void)show;
+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType;
+ (void)showWithStatus:(NSString*)string;
+ (void)showWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)maskType;
```

If you'd like the HUD to reflect the progress of a task, use one of these:

```objective-c
+ (void)showProgress:(CGFloat)progress;
+ (void)showProgress:(CGFloat)progress status:(NSString*)status;
+ (void)showProgress:(CGFloat)progress status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;
```

### Dismissing the HUD

It can be dismissed either right away or after a certain delay using:

```objective-c
+ (void)dismissAfterDuration:(NSTimeInterval)duration;
+ (void)dismiss;
```

If you'd like to stack HUDs, you can balance out every show call using:

```objective-c
+ (void)popActivityAfterDuration:(NSTimeInterval)duration;
+ (void)popActivity;
```

The HUD will get dismissed once the `popActivity` calls will match the number of show calls.  

Or show a confirmation glyph before before getting dismissed a little bit later. The display time depends on the length of the given string (between 0.5 and 5 seconds).

```objective-c
+ (void)showInfoWithStatus:(NSString *)string;
+ (void)showInfoWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType;
+ (void)showSuccessWithStatus:(NSString*)string;
+ (void)showSuccessWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)maskType;
+ (void)showErrorWithStatus:(NSString *)string;
+ (void)showErrorWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType;
+ (void)showImage:(UIImage*)image status:(NSString*)string;
+ (void)showImage:(UIImage*)image status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;
```

## Cancelation

The user can click on the shadow outside the hud to dismiss it, and this block provided by you will be called.

```objective-c
+ (void)setCancelHandler:(SVProgressHUDHandlerBlock)cancelHandler;
```

## Customization

`SVProgressHUD` can be customized via the following methods:

```objective-c
+ (void)setBackgroundColor:(UIColor*)color;                 // default is [UIColor whiteColor]
+ (void)setForegroundColor:(UIColor*)color;                 // default is [UIColor darkGrayColor]
+ (void)setOverlayColor:(UIColor*)color; // default is [UIColor colorWithWhite:0 alpha:0.5]
+ (void)setRingThickness:(CGFloat)width;                    // default is 4 pt
+ (void)setFont:(UIFont*)font;                              // default is [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
+ (void)setInfoImage:(UIImage*)image;                       // default is the bundled info image provided by Freepik
+ (void)setSuccessImage:(UIImage*)image;                    // default is bundled success image from Freepik
+ (void)setErrorImage:(UIImage*)image;                      // default is bundled error image from Freepik
+ (void)setDefaultMaskType:(SVProgressHUDMaskType)maskType; // default is SVProgressHUDMaskTypeNone
+ (void)setViewForExtension:(UIView*)view;                  // default is nil, only used if #define SV_APP_EXTENSIONS is set
```

## Notifications

`SVProgressHUD` posts four notifications via `NSNotificationCenter` in response to being shown/dismissed:
* `SVProgressHUDWillAppearNotification` when the show animation starts
* `SVProgressHUDDidAppearNotification` when the show animation completes
* `SVProgressHUDWillDisappearNotification` when the dismiss animation starts
* `SVProgressHUDDidDisappearNotification` when the dismiss animation completes

Each notification passes a `userInfo` dictionary holding the HUD's status string (if any), retrievable via `SVProgressHUDStatusUserInfoKey`.

`SVProgressHUD` also posts `SVProgressHUDDidReceiveTouchEventNotification` when users touch on the overall screen or `SVProgressHUDDidTouchDownInsideNotification` when a user touches on the HUD directly. For this notifications `userInfo` is not passed but the object parameter contains the `UIEvent` that related to the touch.

## App Extensions

When using `SVProgressHUD` in an App Extension, #define SV_APP_EXTENSIONS to avoid using unavailable APIs. Additionally call `setViewForExtension:` from your extensions view controller with `self.view`.

## Credits

This fork is brought to you by [Tony Borner](https://github.com/tonyunreal).

`SVProgressHUD` was created by [Sam Vermette](http://samvermette.com) and [contributors to the project](https://github.com/samvermette/SVProgressHUD/contributors). 

The info, success and error icons are made by [Freepik](http://www.freepik.com) from [Flaticon](www.flaticon.com) and are licensed under [Creative Commons BY 3.0](http://creativecommons.org/licenses/by/3.0/). 
