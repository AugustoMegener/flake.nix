{ config, pkgs, ... }:
{
	programs.waybar = {
		enable = true;
		settings = [{
			layer = "top";
			position = "top";
			height = 15;
			modules-left = [ "hyprland/workspaces" ];
# modules-center = [ "hyprland/window" ];
			modules-right = [ "tray" "custom/swaync" "cpu" "memory" "clock" ];

			clock = {
				format = "󰃭  {:%F |   %Hh%M}";
			};
			cpu = {
				interval =  10;
				format = "  {}%";
				max-length = 10;
			};
			memory = {
				interval = 30;
				format = "  {}%";
				max-length = 10;
			};
			"hyprland/workspaces" = {
				format = "{icon}";
				format-icons = {
					"1" = "󰎚";
					"2" = "";
					"3" = "󰔶";
					"4" = "";
					"5" = "󰈈";
					default = "󱂬";
				};
				persistent-workspaces = {
					VGA-1 = [ 1 2 3 4 5 ]; 
				};
			};
			"hyprland/window" = {
				height = 15;
			};
#"group/power" = {
#	orientation = "horizontal";
#	modules = [
#
#				];
#			};
			"custom/swaync" = {
				exec = "swaync-client -swb -w";
				on-click = "swaync-client -t";
				return-type = "json";
				format = "{icon}";
				format-icons = {
					notification = "󱅫";
					none = "󰂚";
					dnd-notification = "󰂛";
					dnd-none = "󰂛";
				};
			};
		}];
		style = ./style.css;
	};
}
