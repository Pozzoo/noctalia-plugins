
import QtQuick
import qs.Commons

Rectangle {
    id: badge

    required property string fileName
    required property bool isVideo

    width: badgeRow.width + 16
    height: badgeRow.height + 8
    radius: 6
    color: isVideo ? Color.mSurface : Color.mSurfaceVariant

    Row {
        id: badgeRow
        anchors.centerIn: parent
        spacing: 5

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: badge.isVideo ? "\ue04b" : "\ue3f4"
            color: badge.isVideo ? Color.mOnSurface : Color.mOnSurfaceVariant
            font.family: "Material Symbols Outlined"
            font.pixelSize: 12
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: badge.fileName.substring(badge.fileName.lastIndexOf(".") + 1).toUpperCase()
            color: badge.isVideo ? Color.mPrimary : Color.mSecondary
            font.family: Settings.data.ui.fontDefault
            font.pixelSize: 12
            font.bold: true
            font.letterSpacing: 0.5
        }
    }
}
