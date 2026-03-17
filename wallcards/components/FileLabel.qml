
import QtQuick
import qs.Commons

Rectangle {
    id: label

    required property string fileName
    required property bool isVideo
    required property real shearFactor

    width: Math.min(nameText.implicitWidth + 24, parent.width - 40)
    height: nameText.implicitHeight + 10
    radius: 8
    color: isVideo ? Color.mSurface : Color.mSurfaceVariant

    Text {
        id: nameText
        anchors.centerIn: parent
        width: parent.width
        text: label.fileName.substring(0, label.fileName.lastIndexOf("."))
        color: label.isVideo ? Color.mOnSurface : Color.mOnSurfaceVariant
        font.family: Settings.data.ui.fontDefault
        font.pixelSize: 12
        elide: Text.ElideMiddle
        horizontalAlignment: Text.AlignHCenter
    }

    transform: Shear {
        xFactor: label.shearFactor
    }
}
