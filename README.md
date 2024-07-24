# sacodinexcerise
iOS Application to do inspections

## Requirements 
| Tool| Version |
|--|--|
| Xcode | 15.0 or later  |

## Architecture 
The project is builded with the MVVM Architectural design pattern.

## Structure
```
.
├── sacodinexcerise
│   ├── AppDelegate.swift
│   ├── Assets.xcassets
│   │   ├── AccentColor.colorset
│   │   │   └── Contents.json
│   │   ├── AppIcon.appiconset
│   │   │   ├── Contents.json
│   │   │   └── appLogo.png
│   │   ├── Colors
│   │   │   ├── Contents.json
│   │   │   ├── background.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── buttonColor.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── lightGray.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── oceanBlue.colorset
│   │   │   │   └── Contents.json
│   │   │   └── viewBackground.colorset
│   │   │       └── Contents.json
│   │   ├── Contents.json
│   │   └── onboarding.imageset
│   │       ├── Contents.json
│   │       └── onboarding.png
│   ├── Base.lproj
│   │   └── LaunchScreen.storyboard
│   ├── Common
│   │   ├── AppButtonStyle.swift
│   │   ├── AppColor.swift
│   │   ├── InspectionHelper.swift
│   │   └── SACornerRadiusView.swift
│   ├── Extentions
│   │   ├── DispatchQueue+Extentions.swift
│   │   └── UIKit
│   │       ├── UIButton+Extentions.swift
│   │       ├── UINavigationController+Extentions.swift
│   │       ├── UITableView+Extentions.swift
│   │       ├── UITextField+Extentions.swift
│   │       └── UIViewController+Extention.swift
│   ├── Factory
│   │   └── ServicesFactory.swift
│   ├── Info.plist
│   ├── Layouts
│   │   ├── Authentication.storyboard
│   │   └── Inspection.storyboard
│   ├── Models
│   │   ├── Inspection
│   │   │   └── Inspection.swift
│   │   └── WebResponseError.swift
│   ├── Navigation
│   │   ├── AppEnvironment.swift
│   │   ├── Destinations.swift
│   │   ├── InspectionNavigator.swift
│   │   └── Navigator.swift
│   ├── Networking
│   │   ├── APIConstants.swift
│   │   ├── HTTPMethod.swift
│   │   ├── Router.swift
│   │   └── WebService.swift
│   ├── Sceans 
│   │   ├── Authentication
│   │   │   ├── Login
│   │   │   │   ├── LoginViewController.swift
│   │   │   │   └── LoginViewModel.swift
│   │   │   ├── Onboard
│   │   │   │   ├── OnBoardingViewModel.swift
│   │   │   │   └── OnboardingViewController.swift
│   │   │   └── Signup
│   │   │       ├── SignUpViewController.swift
│   │   │       └── SignUpViewModel.swift
│   │   └── Inspection
│   │       ├── InspectionList
│   │       │   ├── InspectionListViewController.swift
│   │       │   ├── InspectionListViewModel.swift
│   │       │   └── View
│   │       │       ├── CompletedInspectionCell.swift
│   │       │       ├── CompletedInspectionCell.xib
│   │       │       ├── DraftedInspectionCell.swift
│   │       │       └── DraftedInspectionCell.xib
│   │       └── InspectionQuestionsDetails
│   │           ├── InspectioQuestionDetailsViewModel.swift
│   │           ├── InspectionQuestionsDetailsView.swift
│   │           └── View
│   │               ├── InspectionQuestionRowView.swift
│   │               └── InspectionQuestionsDetailsRowView.swift
│   ├── SceneDelegate.swift
│   ├── Services
│   │   ├── Authentication
│   │   │   └── AuthenticationServices.swift
│   │   ├── Database
│   │   │   ├── CoreDataStack.swift
│   │   │   ├── DatabaseServices.swift
│   │   │   ├── StoreInspection.swift
│   │   │   └── StoredDataEntity.swift
│   │   └── Inspection
│   │       └── InspectionService.swift
│   ├── Tools
│   │   ├── ActivityIndicator.swift
│   │   ├── Alert
│   │   │   └── GeneralAlert.swift
│   │   ├── CancelBag.swift
│   │   ├── Loadable.swift
│   │   ├── PersistantType.swift
│   │   ├── SAStoryboard.swift
│   │   └── SwiftLoader.swift
│   └── sacodinexcerise.xcdatamodeld
│       └── sacodinexcerise.xcdatamodel
│           └── contents
├── sacodinexcerise.xcodeproj
│   ├── project.pbxproj
│   ├── project.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   ├── xcshareddata
│   │   │   ├── IDEWorkspaceChecks.plist
│   │   │   └── swiftpm
│   │   │       └── configuration
│   │   └── xcuserdata
│   │       └── psagc.xcuserdatad
│   │           └── UserInterfaceState.xcuserstate
│   └── xcuserdata
│       └── psagc.xcuserdatad
│           ├── xcdebugger
│           │   └── Breakpoints_v2.xcbkptlist
│           └── xcschemes
│               └── xcschememanagement.plist
├── sacodinexceriseTests
│   └── sacodinexceriseTests.swift
└── sacodinexceriseUITests
    ├── sacodinexceriseUITests.swift
    └── sacodinexceriseUITestsLaunchTests.swift
```
