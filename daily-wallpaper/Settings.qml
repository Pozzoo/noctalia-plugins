import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io

ColumnLayout {
    id: root

    property var pluginApi: null
    property var cfg: pluginApi?.pluginSettings || ({})
    property var defaults: pluginApi?.manifest?.metadata?.defaultSettings || ({})
    readonly property string systemLocale: Qt.locale().name.replace("_", "-")
    readonly property string configuredLocale: cfg.locale ?? defaults.locale ?? ""

    property string selectedSource: cfg.source ?? defaults.source ?? "bing"
    property string localeText: configuredLocale && configuredLocale.trim().length > 0
                              ? configuredLocale
                              : systemLocale
    readonly property var sourceOptions: [
        { key: "bing", label: "Bing" },
        { key: "nasa", label: "NASA" }
    ]

    spacing: 12

    Label {
        Layout.fillWidth: true
        text: "Source"
        font.bold: true
    }

    ComboBox {
        id: sourceCombo
        Layout.fillWidth: true
        model: root.sourceOptions
        textRole: "label"
        valueRole: "key"
        Component.onCompleted: {
            currentIndex = root.selectedSource === "bing" ? 0 : 1;
        }
        onActivated: {
            const selected = root.sourceOptions[currentIndex];
            if (selected && selected.key) {
                root.selectedSource = selected.key;
            }
        }
    }

    Loader {
        Layout.fillWidth: true
        active: root.selectedSource === "bing"
        sourceComponent: ColumnLayout {
            spacing: 8

            Label {
                Layout.fillWidth: true
                text: "Locale"
                font.bold: true
            }

            TextField {
                Layout.fillWidth: true
                text: root.localeText
                onTextChanged: {
                    if (text !== root.localeText) {
                        root.localeText = text;
                    }
                }
            }
        }
    }

    Item {
        Layout.fillHeight: true
    }

    function saveSettings() {
        if (!pluginApi) {
            return;
        }

        pluginApi.pluginSettings.source = root.selectedSource;
        pluginApi.pluginSettings.locale = root.localeText;
        pluginApi.saveSettings();

        refreshWallpaper.exec({
            command: [
                "qs",
                "-c",
                "noctalia-shell",
                "ipc",
                "call",
                "plugin:daily-wallpaper",
                "refresh"
            ]
        });
    }

    Process {
        id: refreshWallpaper
        running: false
    }
}
