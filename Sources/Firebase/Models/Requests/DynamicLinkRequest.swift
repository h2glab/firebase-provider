import Vapor

public struct DynamicLinkRequest: FirebaseRequestModel {

    public let dynamicLinkInfo: DynamicLinkInfo
    public let suffix: Suffix

    public init(dynamicLink: DynamicLinkInfo, suffix: Suffix) {
        self.dynamicLinkInfo = dynamicLink
        self.suffix = suffix
    }
}

public struct DynamicLinkInfo: FirebaseRequestModel {

    public let domainUriPrefix: String?
    public let link: String
    public let androidInfo: Android?
    public let iosInfo: Ios?
    public let navigationInfo: Navigation?
    public let analyticsInfo: Analytics?
    public let socialMetaTagInfo: SocialMetaTag?

    public init(domainUriPrefix: String? = nil,
                link: String,
                androidInfo: Android? = nil,
                iosInfo: Ios? = nil,
                navigationInfo: Navigation? = nil,
                analyticsInfo: Analytics? = nil,
                socialMetaTagInfo: SocialMetaTag? = nil) {

        self.domainUriPrefix = domainUriPrefix
        self.link = link
        self.androidInfo = androidInfo
        self.iosInfo = iosInfo
        self.navigationInfo = navigationInfo
        self.analyticsInfo = analyticsInfo
        self.socialMetaTagInfo = socialMetaTagInfo
    }

    public struct Android: FirebaseRequestModel {

        public let androidPackageName: String
        public let androidFallbackLink: String?
        public let androidMinPackageVersionCode: String?

        public init(packageName: String,
                    fallbackLink: String? = nil,
                    minPackageVersionCode: String? = nil) {

            self.androidPackageName = packageName
            self.androidFallbackLink = fallbackLink
            self.androidMinPackageVersionCode = minPackageVersionCode
        }
    }

    public struct Ios: FirebaseRequestModel {

        public let iosBundleId: String
        public let iosAppStoreId: String
        public let iosFallbackLink: String?
        public let iosCustomScheme: String?
        public let iosIpadFallbackLink: String?
        public let iosIpadBundleId: String?

        public init(bundleId: String,
                    appStoreId: String,
                    fallbackLink: String? = nil,
                    customScheme: String? = nil,
                    ipadFallbackLink: String? = nil,
                    ipadBundleId: String? = nil) {

            self.iosBundleId = bundleId
            self.iosAppStoreId = appStoreId
            self.iosFallbackLink = fallbackLink
            self.iosCustomScheme = customScheme
            self.iosIpadFallbackLink = ipadFallbackLink
            self.iosIpadBundleId = ipadBundleId
        }
    }

    public struct Navigation: FirebaseRequestModel {

        public let enableForcedRedirect: Bool

        public init(enableForcedRedirect: Bool) {
            self.enableForcedRedirect = enableForcedRedirect
        }
    }

    public struct Analytics: FirebaseRequestModel {

        public let googlePlayAnalytics: GooglePlay?
        public let itunesConnectAnalytics: ItunesConnect?

        public init(googlePlay: GooglePlay? = nil,
                    itunesConnect: ItunesConnect? = nil) {
            self.googlePlayAnalytics = googlePlay
            self.itunesConnectAnalytics = itunesConnect
        }

        public struct GooglePlay: FirebaseRequestModel {

            public let utmSource: String
            public let utmMedium: String
            public let utmCampaign: String
            public let utmTerm: String
            public let utmContent: String
            public let gclid: String

            public init(utmSource: String,
                        utmMedium: String,
                        utmCampaign: String,
                        utmTerm: String,
                        utmContent: String,
                        gclid: String) {

                self.utmSource = utmSource
                self.utmMedium = utmMedium
                self.utmCampaign = utmCampaign
                self.utmTerm = utmTerm
                self.utmContent = utmContent
                self.gclid = gclid
            }
        }

        public struct ItunesConnect: FirebaseRequestModel {

            public let at: String
            public let ct: String
            public let mt: String
            public let pt: String

            public init(at: String,
                        ct: String,
                        mt: String,
                        pt: String) {

                self.at = at
                self.ct = ct
                self.mt = mt
                self.pt = pt
            }
        }
    }

    public struct SocialMetaTag: FirebaseRequestModel {

        public let socialTitle: String
        public let socialDescription: String
        public let socialImageLink: String

        public init(socialTitle: String,
                    socialDescription: String,
                    socialImageLink: String) {

            self.socialTitle = socialTitle
            self.socialDescription = socialDescription
            self.socialImageLink = socialImageLink
        }
    }
}

public struct Suffix: FirebaseRequestModel {

    public enum Option: String, FirebaseRequestModel {
        case SHORT
        case UNGUESSABLE
    }

    public let option: Option

    public init(option: Option = .SHORT) {
        self.option = option
    }
}
