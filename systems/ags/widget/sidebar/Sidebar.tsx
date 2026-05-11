import { Gtk } from "ags/gtk4";
import Gtk40 from "gi://Gtk";

const SidebarSide = { Left: "Left", Right:"Right" } as const

export type SidebarSide = typeof SidebarSide[keyof typeof SidebarSide];

export function sidebarButton(side: SidebarSide) {
  let button = new Gtk.ToggleButton({
    cssName: "sidebar-button",
    cssClasses: [ side.toLowerCase() ]
  })

  let iconDrawingArea = Gtk.Svg 
}
