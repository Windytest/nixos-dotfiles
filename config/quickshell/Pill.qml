import QtQuick
import QtQuick.Layouts
import "colors/tokyonight.js" as Config
Rectangle {
	id: root

	property string icon: ""
	property string label: ""
	property color iconColor: Config.colors.cyan
	property int maxLabelWidth: 400

	implicitWidth: row.implicitWidth + 22
	implicitHeight: 33
	radius: height / 2
	color: Config.colors.bg
	border.width: 1
	border.color: Config.colors.bg3
	RowLayout {
		id: row
		anchors.centerIn: parent
		spacing: 7

		Text {
			text: root.icon
			color: root.iconColor
			font.family: "Material Symbols Rounded"
			font.pixelSize: 16
		}

		Text {
			text: root.label
			color: Config.colors.fg
			font.family: "JetBrainsMono Nerd Font"
			font.pixelSize: 16
			elide: Text.ElideRight
			Layout.maximumWidth: root.maxLabelWidth
			visible: root.label !== ""
		}
	}
}
