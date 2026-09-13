import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "colors/tokyonight.js" as Config
Rectangle {
    implicitWidth: row.implicitWidth + 22
    implicitHeight: 33
    radius: height / 2
    color: Config.colors.bg
    border.width: 1
    border.color: Config.colors.bg3

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 8

        Repeater {
            model: Hyprland.workspaces

            Rectangle {
                implicitWidth: modelData.focused ? 11 : 6
                implicitHeight: implicitWidth
                radius: width / 2
                color: modelData.focused ? "transparent" : Config.colors.bg3
                border.width: modelData.focused ? 2 : 0
                border.color: Config.colors.cyan

                Behavior on implicitWidth {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
    }
}
