import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { execAsync } from "ags/process"
import { createPoll } from "ags/time"
import { workspacesSelector } from "./hyprland/Workspaces"
import Hyprland from "gi://AstalHyprland"

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const time = createPoll("", 1000, "date")
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  const hyprland = Hyprland.get_default()

  function Workspaces() { return workspacesSelector(hyprland, [ 1, 2, 3, 4, 5 ]) }

  return (
    <window
      visible
      name="bar"
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox cssName="centerbox"> 
        <box $type="start" cssName={"top-bar-left"}>
          <Workspaces/> 
        </box>
        <box $type="center" />
      </centerbox>
    </window>
  )
}
