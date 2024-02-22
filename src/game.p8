pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

_bg = {}
_factory = nil

function start_game()
    _state = _game
    generate_bg()

    -- activate keyboard input
    poke(24365, 1)

    _factory = c_factory:new()
end

function update_game()
    catch_input()

    _factory:update()
end

function draw_game()
    cls(0)

    -- draw_bg()

    _factory:draw()

    spr(1, 60, 120)
end

-----------
-- input --
-----------

function catch_input()
    -- stat(30) => is any key pressed, value is stored inside stat(31)
    if stat(30) == true then
        -- get pressed char
        local char = stat(31)

        -- suppress pause menu keybind
        if char == "\112" then
            poke(0x5f30, 1)
        end

        -- any lowercase alphabetical characters
        if char >= "a" and char <= "z" then
            _factory:add_char(char)
        end

        -- backspace, delete last char
        if char == "\8" then
            _factory:pop_char()
        end
    end
end

----------------
-- background --
----------------

function generate_bg()
    for y = 0, 128 do
        _bg[y] = {}
        for x = 0, 128 do
            local rand = flr(rnd(800))
            if rand == 0 then
                _bg[y][x] = 1
            elseif rand == 1 then
                _bg[y][x] = 7
            elseif rand == 2 then
                _bg[y][x] = 6
            else
                _bg[y][x] = 0
            end
        end
    end
end

function draw_bg()
    for y = 0, 128 do
        for x = 0, 128 do
            pset(x, y, _bg[y][x])
        end
    end
end
