
hl.config { plugin = { dynamic_cursors = {

    -- enables the plugin
    enabled = true,

    -- sets the cursor behaviour, supports these values:
    -- tilt    - tilt the cursor based on x-velocity
    -- rotate  - rotate the cursor based on movement direction
    -- stretch - stretch the cursor shape based on direction and velocity
    -- none    - do not change the cursor's behaviour
    mode = "tilt",

    -- minimum angle difference in degrees after which the shape is changed
    -- smaller values are smoother, but more expensive for hw cursors
    threshold = 2,

    -- TODO: blocos `rotate`, `tilt`, `stretch`, `shake` e `hyprcursor`
    -- removidos temporariamente. O Hyprland acusou 'unknown config key'
    -- pra quase todas as chaves deles (rotate.length, rotate.offset,
    -- tilt.full + mais 12), sobrando só enabled/mode/threshold como
    -- reconhecidas. Isso indica que a versão do plugin hypr-dynamic-cursors
    -- empacotada no seu flake (via pkgs.hyprlandPlugins.hypr-dynamic-cursors)
    -- não bate com o schema do README/config de exemplo que eu usei de base
    -- -- provavelmente é uma versão mais antiga do plugin, de antes desses
    -- sub-blocos existirem.
    --
    -- Rode `hyprctl plugin list` pra ver a versão/commit carregado, compare
    -- com o histórico de VirtCode/hypr-dynamic-cursors no GitHub, e
    -- reintroduza os blocos aos poucos (um de cada vez) conferindo se o
    -- Hyprland aceita as chaves antes de adicionar o próximo.
}}}
