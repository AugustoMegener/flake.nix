import { Gtk } from "ags/gtk4";
import  Hyprland  from "gi://AstalHyprland";

type Hyprland = Hyprland.Hyprland
type Workspace = Hyprland.Workspace


  
export function workspace(hypr: Hyprland, id: Number) {
  let idStr = String(id)

  const focused = hypr.focusedWorkspace.id === id
  console.log(`id: ${id}, focused: ${hypr.focusedWorkspace.id}, match: ${focused}`)


  let workspaceButton = new Gtk.Button({
    cssName     : "hypr-workspace",  
    cssClasses  :  focused ? [ "focused" ] : [],
  })

  workspaceButton.connect("clicked", () => { hypr.dispatch("workspace", idStr) })
  workspaceButton.set_child(new Gtk.Label({ label: idStr }))

  return workspaceButton
}

export function workspacesSelector(hypr: Hyprland, defaults: number[]) {
  let selectorBox = new Gtk.Box()

  selectorBox.set_name("hypr-workspaces-selector")
  selectorBox.set_css_classes([ "hypr-workspaces-selector" ])

  let workspaceEvent = () => {
    while (selectorBox.get_last_child() != null)
      selectorBox.remove(selectorBox.get_last_child()!)

    new Set<number>([...defaults, ...hypr.get_workspaces().map((wp) => wp.id)].sort((a, b) => a - b))
      .forEach((id) => selectorBox.append(workspace(hypr, id)))

    console.log("focused:", hypr.focusedWorkspace.id, typeof hypr.focusedWorkspace.id)
  }

  hypr.connect("notify::workspaces",      workspaceEvent)
  hypr.connect("notify::focused-workspace", workspaceEvent)
  workspaceEvent()

  return selectorBox
}
