import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import "colors/tokyonight.js" as Config

ShellRoot {
	PanelWindow {
		id: bar
		anchors {top: true; left: true; right: true}
		margins {top: 10; left: 4; right: 4}
		implicitHeight: 33
		color: "transparent"

		Poller {
			id: clock
			command: "date +%R"
			interval: 950
		}

		Poller {
			id: vol
			command: "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf\"%d\", $2*100}'"
			interval: 2000
		}
		
		Poller {
			id: bat
			command: "cat /sys/class/power_supply/BAT1/capacity"
			interval: 30000
		}

		Poller {
			id: net
			command: "nmcli -t -f NAME connection show --active | head -n1"
			interval: 5000
		}
		
		readonly property var player: Mpris.players.values.find(p => p.isPlaying) ?? Mpris.players.values[0] ?? null

		RowLayout {
			anchors.left: parent.left
			anchors.verticalCenter: parent.verticalCenter
			anchors.leftMargin: 14
			spacing: 8

			Pill {
				icon: "music_note"
				maxLabelWidth: 200
				label: bar.player ? `${bar.player.trackArtist || "Unknown"} — ${bar.player.trackTitle || ""}` : "Nothing playing"
			}
		}
		RowLayout {
			id: centerGroup
			anchors.centerIn: parent
			spacing: 8
			Pill { icon: "nest_clock_farsight_analog"; label: clock.value}
			Workspaces {}
		}

		RowLayout {
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			anchors.rightMargin: 14
			spacing: 8

			Pill { icon: "volume_up"; label: vol.value + "%"; iconColor: Config.colors.cyan}
			Pill { icon: "battery_android_full"; label: bat.value + "%"; iconColor: Config.colors.green}
			Pill { icon: "android_wifi_3_bar"; label: net.value; iconColor: Config.colors.red}
			Notifications {}
		}
	}
}
