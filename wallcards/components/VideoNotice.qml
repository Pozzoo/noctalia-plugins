
import QtQuick
import qs.Commons

Rectangle {
    id: notice

    required property real shearFactor

    width: noticeRow.width + 20
    height: noticeRow.height + 10
    radius: 8
    color: Color.mSurfaceVariant
    border.width: 1
    border.color: Color.mError

    Row {
        id: noticeRow
        anchors.centerIn: parent
        spacing: 6

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "\ue002"
            color: Color.mError
            font.family: "Material Symbols Outlined"
            font.pixelSize: 14
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "Video wallpaper are not implemented yet."
            color: Color.mError
            font.family: Settings.data.ui.fontDefault
            font.pixelSize: 11
            font.bold: true
        }
    }

    transform: Shear {
        xFactor: notice.shearFactor
    }
}
