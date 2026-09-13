import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import "colors/tokyonight.js" as Config

Scope  {
    id: root
    NotificationServer {
        id: server
	actionsSupported: true
	bodySupported: true
	imageSupported: true
	onNotification: n => {
	    console.log("got:", n.summary, "---", n.body)
	    n.tracked = true
	}


    }
    
    PanelWindow {
	anchors { top: true; right: true }
	margins { top: 51; right: 12 }
	implicitWidth: 380
	implicitHeight: Math.max(1, column.implicitHeight)
	color: "transparent"
	exclusionMode: ExclusionMode.Ignore

	ColumnLayout {
            id: column
	    width: parent.width
	    spacing: 8

	    Repeater {
                model: server.trackedNotifications
		delegate: Rectangle {
		    id: card
		    required property var modelData

		    Timer {
			    running: card.modelData.urgency !== NotificationUrgency.Critical
			    interval: 5000
			    onTriggered: card.modelData.dismiss()

		    }
		    Layout.fillWidth: true
		    Layout.preferredHeight: 60
		    radius: 22
		    color: Config.colors.bg
		    border.width: 1
		    border.color: Config.colors.bg3
		    RowLayout {
                        id: layout
			anchors.fill: parent
			anchors.margins: 10
			spacing: 8

			Image {
                            Layout.preferredHeight: 36
			    Layout.preferredWidth: 36
			    Layout.alignment: Qt.AlignTop
			    fillMode: Image.PreserveAspectFit
			    visible: source.toString() !== ""
			    source: card.modelData.image || card.modelData.appIcon || ""
		        }

			ColumnLayout {
                            Layout.fillWidth: true
			    spacing: 2

			    Text {
	 	                Layout.fillWidth: true
				text: card.modelData.summary
				color: modelData.urgency === NotificationUrgency.Critical ? Config.colors.red :
				modelData.urgency === NotificationUrgency.Normal ? Config.colors.yellow :

				Config.colors.green
				font.family: "JetBrainsMono Nerd Font"
				font.pixelSize: 16
				font.bold: true
				elide: Text.ElideRight
			    }
                            Text {
				Layout.fillWidth: true
				visible: text !== ""
				text: card.modelData.body
				color: Config.colors.fg
				font.family: "JetBrainsMono Nerd Font"
				font.pixelSize: 12
				font.bold: false
				wrapMode: Text.WordWrap
			    }
			}
		    }
		    MouseArea {
                        anchors.fill: parent
			onClicked: card.modelData.dismiss()
		    }
	        }
	    }
	}
    }
}
