pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

function init_menu()
end

function update_menu()
    if btn(4) then start_game() end
end

function draw_menu()
    cls(0)
    print("\^w\^t" .. "type-8", 8, 20)

    print("press 🅾️ to start", 31, 62, 7)

    print("by thevonkanar", 3, 120, 6)
end
