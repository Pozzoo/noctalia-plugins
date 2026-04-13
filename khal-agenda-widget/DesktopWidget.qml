import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Modules.DesktopWidgets
import qs.Widgets

DraggableDesktopWidget {
    id: root
    property var pluginApi: null

    readonly property real _width: Math.round(320 * widgetScale)
    readonly property real _height: Math.round(200 * widgetScale)

    implicitWidth:  _width
    implicitHeight: _height

    property string calendarVal: ""

    Process {
        id: calProc
        command: ["sh", "-c", "khal list today 7d --format '{start-end-time-style} {title}' --day-format '{name}, {date}'"]
        running: root.pluginApi !== null
        stdout: StdioCollector {
            onTextChanged: root.calendarVal = text.trim().replace(/\n\s*\n/g, '\n')
        }
    }

    Process {
        id: openIkhal
        // command: ["kitty", "--config",  "~/.config/kitty/calendar.conf", "--class",  "khal", "-e", "ikhal"]
        command: ["kitty",  "--class",  "khal", "-e", "ikhal"]
            }

    Timer {
        interval: 60000
        running: root.pluginApi !== null
        repeat: true
        onTriggered: {
            calProc.running = false
            calProc.running = true
        }
    }

    Rectangle {
        anchors.fill: parent
        color: Color.mSurface
        opacity: 0.85
        radius: Style.radiusM

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Style.marginL

            RowLayout {
                Layout.fillWidth: true

                NText {
                    text: pluginApi.tr("widget.heading")
                    color: Color.mOnSurfaceVariant
                    font.pointSize: Style.fontSizeL * widgetScale
                    Layout.fillWidth: true
                }

                Button {
                    text: "📅"
                    flat: true
                    background: null
                    onClicked: {
                        openIkhal.running = false
                        openIkhal.running = true
                    }
                }
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                NText {
                    width: parent.width - 10
                    text: root.calendarVal !== "" ? root.calendarVal : pluginApi.tr("widget.no_events")
                    color: Color.mOnSurface
                    font.pointSize: Style.fontSizeL * widgetScale
                    wrapMode: Text.NoWrap
                    elide: Text.ElideRight
                    font.family: "Monospace"
                }
            }
        }
    }
}
