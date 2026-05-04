import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { execAsync } from "ags/process"
import Hyprland from "gi://AstalHyprland"
import Workspace from "gi://AstalHyprland"

import { createPoll } from "ags/time"


export default function Bar(gdkmonitor: Gdk.Monitor) {
  const time = createPoll("", 1000, "date")
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  const hyprland = Hyprland.get_default()

  const workspaces = hyprland.workspaces


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
    <box cssName="leftbox">
      <box cssName={"workspaceList"}> 
        {workspaces.map(w => {
          return <button css_classes={(hyprland.focusedWorkspace == w) ? [ "workspace", "focused" ] : [ "workspace" ] }> 
            <label label={String(w.id)}/>
          </button>
        })}
      </box>
    </box>
    <centerbox cssName="centerbox">
        <label label="wo"/>
    </centerbox>
    </window>
  )
}
