import QtQuick 2.1
import Sailfish.Silica 1.0

QtObject {
    id: constant

    property string appName: "Falldown"

    // easier access to colors
    property color colorHighlight: Theme.highlightColor
    property color colorPrimary: Theme.primaryColor
    property color colorSecondary: Theme.secondaryColor
    property color colorHilightSecondary: Theme.secondaryHighlightColor
    property color backgroundColor: Theme.rgba(Theme.secondaryHighlightColor, 0.1)

    property color iconDefaultColor: Theme.rgba(Theme.secondaryColor, 0.4)

    // easier access to padding size
    property int paddingSmall: Theme.paddingSmall
    property int paddingMedium: Theme.paddingMedium
    property int paddingLarge: Theme.paddingLarge
    property int paddingExtraLarge: 2 * Theme.paddingMedium

    // easier access to font size
    property int fontSizeTiny: Theme.fontSizeTiny
    property int fontSizeExtraSmall: Theme.fontSizeExtraSmall
    property int fontSizeSmall: Theme.fontSizeSmall
    property int fontSizeMedium: Theme.fontSizeMedium
    property int fontSizeLarge: Theme.fontSizeLarge
    property int fontSizeExtraLarge: Theme.fontSizeExtraLarge
    property int fontSizeHuge: Theme.fontSizeHuge

    property int iconSizeLarge: Theme.iconSizeLarge
    property int iconSizeMedium: Theme.iconSizeMedium
    property int iconSizeSmall: Theme.iconSizeSmall

    // easier access to item size
    property int itemSizeExtraLarge: Theme.itemSizeExtraLarge
    property int itemSizeExtraSmall: Theme.itemSizeExtraSmall
    property int itemSizeHuge: Theme.itemSizeHuge
    property int itemSizeLarge: Theme.itemSizeLarge
    property int itemSizeMedium: Theme.itemSizeMedium
    property int itemSizeSmall: Theme.itemSizeSmall

}
